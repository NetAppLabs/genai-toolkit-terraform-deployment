subscription = "081989d8-7ae0-4884-b3c4-ff43a1dcfbe0"
resource_group_name = "GA_test"
location = "Sweden Central"
vnet = "GA-vnet"
subnetid = "/subscriptions/081989d8-7ae0-4884-b3c4-ff43a1dcfbe0/resourceGroups/GA_test/providers/Microsoft.Network/virtualNetworks/GA-vnet/subnets/default"
admin_username = "adminuser"
admin_password = "Admin123"
admin_ssh_key_file_location = "/Users/hinrikmarhreinsson/.ssh/id_rsa.pub"
source_ip_range = "*"

anf_volumes = ["10.0.1.4:/movies-volume",
               "10.0.1.4:/csv-volume",
               "10.0.1.4:/animal-info-volume",
               "10.0.1.4:/json-volume",
               "10.0.1.4:/products-volume"
]
ontap_volumes = []
