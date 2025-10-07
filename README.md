# AWS Active Directory en EC2 - Guía de Despliegue

Implementación de Active Directory Domain Services (ADDS) en instancias EC2 con Windows Server siguiendo un patrón arquitectónico estandarizado.

## 🎯 Propósito

Este repositorio proporciona infraestructura como código (Terraform) para desplegar Active Directory en EC2 manteniendo consistencia, seguridad, disponibilidad y gobernanza.

## 🏗️ Arquitectura

### Patrón por Capas
```
┌──────────────────────────────┐
│     Capa de Validación        │
│ (Pruebas, auditoría, monitoreo) │
└──────────────┬───────────────┘
               │
┌──────────────┴───────────────┐
│     Capa de Directorio        │
│      (ADDS en EC2)            │
└──────────────┬───────────────┘
               │
┌──────────────┴───────────────┐
│        Capa Base              │
│ (VPC, seguridad, IAM, DNS,    │
│  monitoreo y gobernanza)      │
└──────────────────────────────┘
```

## 📁 Estructura del Proyecto

```
├── README.md
├── build_README.md              # Documentación completa
├── playbook.md                  # Playbook arquitectónico
├── infrastructure-ad/           # Capa Base (Core Layer)
│   ├── versions.tf
│   ├── provider.tf
│   ├── backend.tf
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── compute.tf              # Bastion host
│   ├── dns.tf                  # Route53 privado
│   ├── iam.tf                  # Roles IAM
│   ├── monitoring.tf           # CloudTrail y logs
│   ├── secrets.tf              # Secrets Manager
│   ├── security.tf             # Security Groups
│   └── terraform.tfvars.example
├── ec2-ad/                      # ADDS en EC2
│   ├── versions.tf
│   ├── provider.tf
│   ├── backend.tf
│   ├── data.tf                 # Referencias a infraestructura base
│   ├── main.tf                 # Domain Controllers
│   ├── variables.tf
│   ├── outputs.tf
│   ├── iam.tf                  # Roles para DCs
│   ├── dns.tf                  # Route53 records
│   ├── monitoring.tf           # CloudWatch
│   ├── backup.tf               # AWS Backup
│   ├── user_data.ps1           # Script PowerShell
│   └── terraform.tfvars.example
└── client-ad/                   # Cliente Windows para pruebas
    ├── versions.tf
    ├── provider.tf
    ├── backend.tf
    ├── data.tf
    ├── locals.tf
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    ├── iam.tf
    ├── security.tf
    ├── user_data.ps1
    └── terraform.tfvars.example
```

## 🚀 Despliegue

### 1. Infraestructura Base (Obligatorio)

La capa base debe desplegarse primero y proporciona los cimientos para el Active Directory:

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
cd ec2-ad
cp terraform.tfvars.example terraform.tfvars
# Configurar dominio y credenciales
terraform init
terraform plan
terraform apply
```

### 3. Cliente Windows para Pruebas (Opcional)

```bash
cd client-ad
cp terraform.tfvars.example terraform.tfvars
# Configurar ad_type = "ec2-ad"
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

### ec2-ad/terraform.tfvars
```hcl
project_name = "mi-ad"
domain_name = "miempresa.local"
domain_netbios_name = "MIEMPRESA"
key_pair_name = "mi-keypair"
ad_admin_password = "MiPassword123!"
safe_mode_password = "MiSafeModePassword123!"
```

## 📋 Criterios de Calidad

| Criterio | Implementación |
|----------|----------------|
| **Seguridad** | Sin exposición pública, acceso via bastion host |
| **Disponibilidad** | Multi-AZ, monitoreo de salud |
| **Escalabilidad** | Crecimiento horizontal/vertical sin rediseño |
| **Gobernanza** | CloudTrail, Config y CloudWatch habilitados |
| **Automatización** | IaC con Terraform |
| **Recuperación** | Políticas de backup automático |

## 🔧 Componentes de la Capa Base

- **VPC y Subnets**: Infraestructura aislada multi-AZ
- **Security Groups**: Reglas para LDAP, RDP y replicación
- **IAM**: Roles con principio de menor privilegio
- **Bastion Host**: Acceso administrativo controlado
- **DNS**: Route 53 privado para resolución interna
- **Monitoreo**: CloudWatch, Config y CloudTrail
- **Credenciales**: AWS Secrets Manager

## 📊 Características del ADDS en EC2

### Funcionalidades Principales
- **Controladores de Dominio**: Múltiples DCs en diferentes AZs
- **Replicación Automática**: Sincronización entre controladores
- **Backup Automático**: AWS Backup con retención configurable
- **Monitoreo**: CloudWatch logs y métricas
- **Escalabilidad**: Hasta 4 controladores de dominio
- **Personalización**: Control total sobre políticas y configuración

### Script PowerShell Automatizado
- Instalación de AD DS Role
- Configuración de CloudWatch Agent
- Creación de bosque (primer DC)
- Unión de DCs adicionales al dominio
- Configuración DNS automática
- Reinicio automático post-configuración

## 📋 Resultado del Despliegue

- **2+ Controladores de Dominio** en diferentes AZs
- **Replicación automática** entre DCs
- **Backup diario** con AWS Backup
- **Monitoreo** con CloudWatch
- **Acceso seguro** via bastion host
- **DNS interno** configurado automáticamente

## 🔗 Acceso y Administración

### Acceso RDP
1. **Conectar al Bastion**: `ssh -i mi-keypair.pem ec2-user@<bastion-ip>`
2. **RDP a DCs**: Desde bastion a IPs privadas de los DCs
3. **Credenciales**: Administrator / MiPassword123!

### Herramientas Administrativas
- **Active Directory Users and Computers**
- **DNS Manager**
- **Group Policy Management**
- **Active Directory Sites and Services**

## 🛡️ Buenas Prácticas Implementadas

- **Acceso**: Solo via bastion host, sin exposición pública
- **Disponibilidad**: Despliegue en múltiples AZs
- **Automatización**: Configuración completamente automatizada
- **Monitoreo**: Logs centralizados en CloudWatch
- **Backup**: Políticas de respaldo automático
- **Seguridad**: Encriptación de volúmenes y tráfico

## 📝 Validaciones Post-Despliegue

- ✅ Controladores de dominio activos y replicando
- ✅ Resolución DNS interna funcionando
- ✅ Acceso RDP desde bastion host
- ✅ Logs enviados a CloudWatch
- ✅ Políticas de backup activas
- ✅ Replicación entre DCs verificada

## 🤝 Contribución

1. Fork el repositorio
2. Crea una rama para tu feature
3. Commit tus cambios
4. Push a la rama
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para detalles.
