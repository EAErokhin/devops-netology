# locals {
#     type = object(map(list(string)))
#     default = {
#         vm1 = {
#             env = develop
#             project = platform
#             role = web
#         }
#         vm2 = {
#             env = develop
#             project = platform
#             role = db            
#         }
#     }
#     name = "netology-${vm1.env}"
# }

locals {
  vm1_env = "netology"
  vm1_project = "develop"
  vm1_platform = "platform"
  vm1_role = "web"

  vm2_env = "netology"
  vm2_project = "develop"
  vm2_platform = "platform"
  vm2_role = "db"

  vms = [
    "${local.vm1_env}-${local.vm1_project}-${local.vm1_platform}-${local.vm1_role}",
    "${local.vm2_env}-${local.vm2_project}-${local.vm2_platform}-${local.vm2_role}"
  ]
}