locals {
  INSTANCE_ENV = var.ENVIRONMENT == "prod" ? "production" : "non-production"
}
