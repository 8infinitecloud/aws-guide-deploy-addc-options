# AWS Active Directory Deployment Guide

Implementación de Active Directory en AWS siguiendo un patrón arquitectónico estandarizado con enfoque en criterios de calidad.

## 🎯 Propósito

Este repositorio proporciona infraestructura como código (Terraform) para desplegar cualquier tipo de Active Directory en AWS manteniendo consistencia, seguridad, disponibilidad y gobernanza.

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
│ (Managed AD | AD Connector |   │
│  Simple AD | ADDS en EC2)      │
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
├── base-infrastructure/          # Capa Base (Core Layer)
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars.example
├── managed-ad/                   # AWS Managed Microsoft AD
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars.example
├── ad-connector/                 # AD Connector
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars.example
├── simple-ad/                    # Simple AD
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars.example
├── adds-ec2/                     # ADDS en EC2
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars.example
└── domain-client/                # Cliente Windows para dominio
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    ├── user_data.ps1
    └── terraform.tfvars.example
```

## 🚀 Despliegue

### 1. Infraestructura Base (Obligatorio)

La capa base debe desplegarse primero y proporciona los cimientos para cualquier tipo de AD:

```bash
cd base-infrastructure
cp terraform.tfvars.example terraform.tfvars
# Editar terraform.tfvars con tus valores
terraform init
terraform plan
terraform apply
```

### 2. Seleccionar Tipo de Active Directory

Elige una de las cuatro opciones según tu caso de uso:

#### AWS Managed Microsoft AD
```bash
cd managed-ad
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

#### AD Connector
```bash
cd ad-connector
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

#### Simple AD
```bash
cd simple-ad
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

#### ADDS en EC2
```bash
cd adds-ec2
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

### 3. Cliente Windows para Dominio (Opcional)

Despliega clientes Windows que se unen automáticamente al dominio:

```bash
cd domain-client
cp terraform.tfvars.example terraform.tfvars
# Configurar ad_type según el tipo de AD desplegado
terraform init
terraform plan
terraform apply
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

## 📊 Casos de Uso por Tipo

### AWS Managed Microsoft AD
- Directorio corporativo escalable sin administración manual
- Integración nativa con servicios AWS
- Extensión/reemplazo de AD on-premises

### AD Connector
- Autenticación centralizada sin replicar datos
- Integración con AD existente on-premises
- Extensión temporal durante migraciones

### Simple AD
- Ambientes de desarrollo y capacitación
- Aplicaciones ligeras con autenticación básica
- Pruebas de concepto (PoC)

### ADDS en EC2
- Migraciones "lift-and-shift"
- Personalización avanzada de políticas
- Integración con sistemas legacy

## 🛡️ Buenas Prácticas

- **Acceso**: Usar bastion host, VPN o Direct Connect
- **Disponibilidad**: Desplegar en al menos dos AZs
- **Automatización**: Versionar configuraciones con IaC
- **Monitoreo**: Centralizar logs en CloudWatch
- **Costos**: Dimensionar según carga real
- **Backup**: Implementar restauraciones periódicas

## 📝 Validaciones Post-Despliegue

- ✅ Disponibilidad de controladores/servicios
- ✅ Resolución DNS interna del dominio
- ✅ Replicación entre controladores (si aplica)
- ✅ Autenticación de instancias al dominio
- ✅ Generación de logs en CloudWatch
- ✅ Políticas de backup funcionando

## 🤝 Contribución

1. Fork el repositorio
2. Crea una rama para tu feature
3. Commit tus cambios
4. Push a la rama
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para detalles.
