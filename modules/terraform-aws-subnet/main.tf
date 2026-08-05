terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

resource "aws_subnet" "this" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_block
  availability_zone = var.availability_zone

  map_public_ip_on_launch     = var.map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation

  ipv6_cidr_block = var.ipv6_cidr_block

  tags = merge(
    var.tags,
    {
      Name = var.name
    }
  )
}

resource "aws_route_table" "this" {
  count = var.create_route_table ? 1 : 0

  vpc_id = var.vpc_id

  dynamic "route" {
    for_each = var.default_route_target_id != null ? [1] : []
    content {
      cidr_block = "0.0.0.0/0"
      gateway_id = var.default_route_target_type == "gateway_id" ? var.default_route_target_id : null
      nat_gateway_id = var.default_route_target_type == "nat_gateway_id" ? var.default_route_target_id : null
      transit_gateway_id = var.default_route_target_type == "transit_gateway_id" ? var.default_route_target_id : null
    }
  }

  dynamic "route" {
    for_each = var.additional_routes
    content {
      cidr_block                = route.value.cidr_block
      gateway_id                = try(route.value.gateway_id, null)
      nat_gateway_id            = try(route.value.nat_gateway_id, null)
      transit_gateway_id        = try(route.value.transit_gateway_id, null)
      vpc_peering_connection_id = try(route.value.vpc_peering_connection_id, null)
      network_interface_id      = try(route.value.network_interface_id, null)
    }
  }

  tags = merge(var.tags, { Name = "${var.name}-rt" })
}

resource "aws_route_table_association" "created" {
  count = var.create_route_table ? 1 : 0

  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.this[0].id
}

resource "aws_route_table_association" "existing" {
  count = var.create_route_table ? 0 : (var.route_table_id != null ? 1 : 0)

  subnet_id      = aws_subnet.this.id
  route_table_id = var.route_table_id
}
