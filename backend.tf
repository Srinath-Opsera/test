terraform {
  cloud {
    # Replaced automatically during deployment with the selected TFC organization
    organization = "SE-Team"
    workspaces {
      # Replaced automatically during deployment with the selected TFC workspace name
      name = "{taggroup}-dev"
    }
  }
}
