# Active Directory en EC2 - Guía de Despliegue

Despliegue de Active Directory Domain Services (ADDS) en instancias EC2 con Windows Server.

## 🚀 Despliegue Rápido

### 1. Infraestructura Base
```bash
cd infrastructure-ad
cp terraform.tfvars.example terraform.tfvars
# Editar terraform.tfvars con tus valores
terraform init
terraform plan
terraform apply
```

### 2. Active Directory en EC2
```bash
cd ad-ec2
cp terraform.tfvars.example terraform.tfvars
# Configurar dominio y credenciales
terraform init
terraform plan
terraform apply
```

### 3. Cliente Windows (Opcional)
```bash
cd client-ad
cp terraform.tfvars.example terraform.tfvars
# Configurar ad_type = "adds-ec2"
terraform init
terraform plan
terraform apply
```

## ⚙️ Configuración Mínima

### infrastructure-ad/terraform.tfvars
```hcl
project_name = "mi-ad"
domain_name = "miempresa.local"
key_pair_name = "mi-keypair"
ad_admin_password = "MiPassword123!"
```

### ad-ec2/terraform.tfvars
```hcl
project_name = "mi-ad"
domain_name = "miempresa.local"
domain_netbios_name = "MIEMPRESA"
key_pair_name = "mi-keypair"
ad_admin_password = "MiPassword123!"
safe_mode_password = "MiSafeModePassword123!"
```

## 📋 Resultado

- **2 Controladores de Dominio** en diferentes AZs
- **Replicación automática** entre DCs
- **Backup diario** con AWS Backup
- **Monitoreo** con CloudWatch
- **Acceso seguro** via bastion host

## 🔗 Acceso

1. **RDP al Bastion**: `ssh -i mi-keypair.pem ec2-user@<bastion-ip>`
2. **RDP a DCs**: Desde bastion a IPs privadas de los DCs
3. **Credenciales**: Administrator / MiPassword123!

Para documentación completa ver `build_README.md`
