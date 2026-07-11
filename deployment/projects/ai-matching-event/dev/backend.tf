terraform {
  cloud {
    organization = "saxenasharad-org"
    workspaces {
      name = "ingenovis-ai-matching-1-dev"
    }
  }
}