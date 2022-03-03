locals {
  INSTANCE_ENV = var.ENVIRONMENT == "prod" ? "production" : "non-production"
  INSTANCE_TYPE = var.ENVIRONMENT == "prod" ? "t2.medium" : "t2.micro"
}
