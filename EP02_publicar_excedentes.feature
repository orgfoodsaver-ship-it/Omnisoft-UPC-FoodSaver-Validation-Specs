"User Stories Conectadas:

US05: Publicar Pack Sorpresa del día con precio reducido.

US06: Configurar horario límite para el recojo de excedentes en tienda."
Feature: Publicar excedentes
  Como socio gastronómico de FoodSaver
  Quiero registrar y publicar los excedentes alimentarios del día
  Para monetizar productos aptos para el consumo que no se vendieron en el turno regular.

  Scenario Outline: Publicar exitosamente un Pack Sorpresa con precio reducido (US05)
    Given que el socio gastronómico con ID <socio_id> se encuentra autenticado en el sistema
    And su establecimiento comercial tiene el estado de operaciones "Activo"
    When ingresa al panel de publicación e introduce el nombre del pack como <nombre_pack>
    And define el precio original en <precio_orig> soles y el precio de oferta en <precio_desc> soles
    And establece la cantidad de unidades disponibles en <stock>
    Then el sistema debe guardar el Pack Sorpresa con estado "Disponible"
    And el catálogo público geolocalizado debe actualizarse de manera síncrona en un tiempo menor a 2 segundos

    Examples:
      | socio_id | nombre_pack              | precio_orig | precio_desc | stock |
      | "REST-01"| "Pack Desayuno Pastelería"| 35.00       | 12.00       | 5     |
      | "REST-02"| "Pack Almuerzo Criollo"  | 45.00       | 18.00       | 3     |

  Scenario: Configurar exitosamente el horario límite para el recojo de excedentes (US06)
    Given que el socio gastronómico ha creado un Pack Sorpresa con ID "PACK-202"
    When configura el rango horario de recojo desde las "18:00" hasta las "21:00" horas del día actual
    Then el sistema debe asociar las restricciones horarias al identificador del lote
    And debe advertir al consumidor en la interfaz móvil que la orden se cancelará automáticamente a las "21:01" horas.

  Scenario: Intento fallido de publicación por ingresar un precio de oferta mayor al original (Robustez ABET 6)
    Given que el socio gastronómico se encuentra en la interfaz de creación de ofertas
    When ingresa un precio original de "20.00" soles
    And digita por error un precio promocional de "25.00" soles
    Then el sistema debe bloquear el envío del formulario de registro
    And debe desplegar el mensaje de error: "Operación inválida: El precio de oferta no puede exceder o igualar al precio comercial regular".