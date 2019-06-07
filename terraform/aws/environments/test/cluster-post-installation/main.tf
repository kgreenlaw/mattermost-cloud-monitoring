terraform {
  required_version = ">= 0.11"
  backend "s3" {
    bucket = "terraform-cloud-monitoring-state-bucket-test"
    key    = "central-monitoring-cluster-post-installation"
    region = "us-east-1"
  }
}


provider "aws" {
  region = "${var.region}"
  alias  = "post-deployment"
}


module "cluster-post-installation" {
  source = "../../../modules/cluster-post-installation"
  deployment_name = "${var.deployment_name}"
  region = "${var.region}"
  tiller_version = "${var.tiller_version}"
  kubeconfig_dir = "${var.kubeconfig_dir}"
  providers = {
    aws = "aws.post-deployment"
  }
}