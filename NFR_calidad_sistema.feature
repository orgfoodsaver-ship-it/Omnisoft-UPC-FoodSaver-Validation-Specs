"User Stories Conectadas:

US_NFR01 (Seguridad): Cifrado de datos sensibles de pago en pasarela móvil.

US_NFR02 (Seguridad): Validación perimetral y autenticación multifactor para perfiles comerciales.

US_NFR03 (Rendimiento): Tiempo de respuesta del motor de geolocalización bajo alta concurrencia.

US_NFR04 (Disponibilidad): Tolerancia a fallos y persistencia local ante interrupciones de conectividad móvil en Lima Metropolitana."
Feature: Atributos de Calidad del Sistema
  Como arquitecto de software de FoodSaver
  Quiero garantizar el cumplimiento de los estándares de seguridad, rendimiento y alta disponibilidad
  Para mitigar riesgos técnicos y asegurar una experiencia operativa robusta y confiable.

  Scenario: Cifrado extremo a extremo de tokens de transacciones financieras (US_NFR01 - Seguridad)
    Given que un consumidor final ha seleccionado un método de pago digital "Yape"
    And la pasarela se encuentra lista para procesar el pago de la orden por un monto de "15.00" soles
    When el usuario confirma la transacción y se invoca el SDK de pagos integrado
    Then el sistema debe encriptar el token financiero utilizando el estándar AES-256 antes de transmitirlo al backend
    And la base de datos no debe registrar bajo ninguna circunstancia el PIN o número de tarjeta en texto plano.

  Scenario Outline: Autenticación perimetral estricta para comercios asociados (US_NFR02 - Seguridad)
    Given que un usuario con perfil socio intenta ingresar al módulo administrativo desde una dirección IP no registrada
    When introduce sus credenciales de acceso <usuario> y contrasenia <clave>
    Then el sistema debe exigir un código de verificación de un solo uso (OTP) enviado a su teléfono registrado
    And si el token OTP introducido es incorrecto por <intentos> veces consecutivas, el acceso se bloqueará por 15 minutos.

    Examples:
      | usuario               | clave        | intentos |
      | "administrador_bod1"  | "P@ssw0rd12" | 3        |

  Scenario: Tiempo de respuesta en búsquedas geolocalizadas concurrentes (US_NFR03 - Rendimiento)
    Given que la plataforma experimenta una carga simulada de "500" peticiones simultáneas por minuto desde Lima Metropolitana
    When un consumidor final ejecuta un filtro de búsqueda de ofertas en un radio de "2" kilómetros a la redonda
    Then el motor de base de datos geoespacial debe procesar y retornar el arreglo de restaurantes en un tiempo inferior a "1.5" segundos
    And la tasa de error HTTP de las respuestas del servidor debe ser de "0.0%".

  Scenario: Persistencia y resiliencia local ante fallos de conectividad en tiendas (US_NFR04 - Disponibilidad)
    Given que el socio minorista se encuentra verificando órdenes físicas mediante escaneo QR en su bodega
    And el dispositivo móvil pierde el acceso a la red de datos móviles (4G/5G)
    When el socio escanea el código QR del cliente "ORD-888" en modo desconectado
    Then la aplicación móvil debe validar la firma criptográfica local del QR de forma temporal
    And debe almacenar la transacción en la cola local indexada del dispositivo para sincronizarla automáticamente apenas retorne la conectividad de red.
    