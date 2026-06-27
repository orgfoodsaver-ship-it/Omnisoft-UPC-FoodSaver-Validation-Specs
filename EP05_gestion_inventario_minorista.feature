"User Stories Conectadas:

US28: Armar lotes mixtos de la canasta básica.

US29: Modificar descripción del contenido del lote minorista.

US30: Dar de baja un pack dañado antes de ser reservado."
Feature: Gestión de Inventario Minorista (Bodegas)
  Como socio minorista de FoodSaver
  Quiero registrar y administrar de manera ágil los lotes y excedentes de mi bodega
  Para reducir la merma de mis saldos y recuperar su valor comercial.

  Scenario Outline: Crear un lote mixto de productos de la canasta básica (US28)
    Given que el socio minorista con ID <socio_id> ha iniciado sesión en la plataforma
    And posee un stock inicial de <productos> aptos para el consumo
    When procede a agrupar los productos bajo la categoría "Lote Mixto Canasta"
    And asigna un precio promocional de <precio> soles
    Then el sistema debe registrar el nuevo Pack Sorpresa en la base de datos de inventario
    And el estado del pack debe cambiar a "Disponible" en el catálogo geolocalizado de los usuarios

    Examples:
      | socio_id  | productos                     | precio |
      | "BOD-401" | "Arroz, Leche Eva, Conservas" | 15.00  |
      | "BOD-402" | "Fideos, Aceite vegetal"      | 12.50  |

  Scenario: Modificar la descripción del contenido de un lote publicado (US29)
    Given que el socio minorista ha publicado un Pack Sorpresa con ID "PACK-999"
    And el estado actual del pack en la plataforma es "Disponible"
    When el socio actualiza la descripción del contenido a "Incluye 2 tarros de leche y 1kg de arroz"
    Then el sistema debe guardar los cambios en el backend de manera síncrona
    And el catálogo público debe reflejar la nueva descripción de forma inmediata

  Scenario: Intento de modificación fallido de un pack que ya fue reservado (Flujo Alternativo / ABET 6)
    Given que el socio minorista ha publicado un Pack Sorpresa con ID "PACK-777"
    And un consumidor final ya ha cambiado el estado del pack a "Reservado"
    When el socio intenta modificar la descripción del contenido del lote
    Then el sistema debe denegar la operación de actualización
    And debe desplegar un mensaje de error notificando: "No se puede editar un lote que ya ha sido reservado por un cliente"

  Scenario: Dar de baja un Pack Sorpresa dañado antes de recibir reservas (US30)
    Given que existe un Pack Sorpresa con ID "PACK-404" publicado en la plataforma
    And el estado del lote en el inventario es "Disponible"
    When el socio minorista reporta el lote en la interfaz con la causal "Producto Dañado"
    Then el sistema debe retirar el pack del catálogo visible para los consumidores finales
    And debe actualizar el estado del lote en el repositorio central a "Cancelado por Merma"