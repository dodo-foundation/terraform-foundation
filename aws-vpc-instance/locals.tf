locals {
  INSTANCE_ENV         = var.ENVIRONMENT == "prod" ? "production" : "non-production"
  INSTANCE_TYPE        = var.ENVIRONMENT == "prod" ? "t2.medium" : "t2.micro"
  ADD_INSTANCE_ENV     = local.INSTANCE_ENV == "production" ? "krishna" : "vignesh"
  ADD_ADD_INSTANCE_ENV = local.ADD_INSTANCE_ENV == "krishna" ? "junior" : "senior"

}
