terraform {
  backend "remote" {
    organization = "TF01"
    
    workspaces {
      name = "my-app-dev"
    }
  }
}