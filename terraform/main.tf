provider "local" {}

#1. Simular la creacion de un servidor (como si fuera un EC2 AWS)

resource "local_file" "servidor_produccion" {
	content = "Servidor Ubuntu 24.04 - IP: 192.168.1.100"
	filename = "${path.module}/servidor_simulado.txt"
}

#2. PUENTE DE CONEXION T A, Crear el hosts.ini para ansible
resource "local_file" "generar_inventario_ansible" {
	content = <<EOF
[produccion]
localhost ansible_connection=local

[produccion:vars]
entorno=produccion_critica
EOF
	filename = "../ansible/hosts.ini"
#Obligatorio a terraform a crear el servidor PRIMERO
depends_on = [local_file.servidor_produccion]
}
