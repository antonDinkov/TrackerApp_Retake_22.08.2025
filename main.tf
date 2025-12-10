terraform {
  required_providers {
    docker = {
      source  = "bierwirth-it/docker"
      version = "3.0.5"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"

  registry_auth {
    address = "registry-1.docker.io"
    username = "antondinkov"
    password = "9BL147zkw"
  }
}

resource "docker_image" "trackerapp" {
  name = "registry-1.docker.io/antondinkov/trackerapp123:1.0"

  build {
    context    = "${path.module}"
    dockerfile = "${path.module}/Dockerfile"
  }
}

resource "docker_registry_image" "trackerapp_remote" {
  name          = docker_image.trackerapp.name
  keep_remotely = true
}
