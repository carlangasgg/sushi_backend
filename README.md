
# Niufoods Backend

Se crea un proyecto en Ruby on Rails como API para alimentar, via consultas, a un software frontend desarrollado en React.js.
Además, es posible hacer consultas API Rest.

Por otra parte, se desarrolla un pequeño script que simula la modificación de datos, vía API Rest, a la consola.

Para la lectura del frontend, se implementó endpoints asincrónicos, manejados por Sidekiq.


## Stack utilizado para el backend

**Ruby on Rails:** Ruby v.3.2.3, Rails v.7.1.5

**DB:** PostgreSQL

**Gemas relevantes:**

    gem "redis"
    gem 'sidekiq'
    gem 'sidekiq-scheduler'
    gem 'sidekiq-cron'
    gem "rack-cors"
    gem 'jsonapi-serializer'
    gem 'httparty'

**Redis:** Redis server v.7.4.1

**Sidekiq:** Sidekiq v.7.3.6


## El repositorio

Clonar el proyecto

```bash
  git clone https://github.com/carlangasgg/sushi_backend.git
```

Ir a la carpeta del proyecto

```bash
  cd [Directorio creado para el proyecto]
```

Instalar dependencias

```bash
  bundle install
```

Crear y poblar base de datos

```bash
  bin/rails db:create
  bin/rails db:migrate
  bin/rails db:seed
```

Levantar servidor de Rails

```
  rails server
```

Realizar primera carga de datos del caché para el cron

```
  rails console
  FetchPosJob.perform_async
```

Levantar servidor de Sidekiq

```
  bundle exec sidekiq
```

Ejecutar script de simulación de uso de la API
```
  ruby test_script.rb
```

El directorio de APP debe lucir asi:

```
...

├── controllers
│   ├── admin
│   │   └── admin_controller.rb
│   ├── application_controller.rb
│   ├── concerns
│   └── device
│       └── device_controller.rb
├── jobs
│   ├── application_job.rb
│   ├── fetch_pos_job.rb
│   ├── fetch_printers_job.rb
│   └── fetch_red_systems_job.rb
├── mailers
│   └── application_mailer.rb
├── models
│   ├── application_record.rb
│   ├── concerns
│   ├── device.rb
│   ├── local.rb
│   ├── pos.rb
│   ├── printer.rb
│   ├── red_system.rb
│   ├── status_log.rb
│   └── user.rb
├── serializers
│   └── device_serializer.rb
...
```

## A considerar

- Se utilizó Sidekiq para consultas del frontend para revisar el estado de punto de ventas, impresoras y sistemas de red, dispotivos indicados para la ejecución de esta prueba.

- Los tres dispositivos señalados anteriormente, fueron incorporados a la base de datos como modelos Pos, Printer y RedSystem, con la posibilidad de ampliar a más tipos de dispositivos con sus respectivos modelos, pues fueron creados como polimorfismos del modelo principal Device.

- El cron está seteado para ejecutarse una vez cada 1 minuto, al igual que el script de simulación de transacciones


## APIs Utilizadas

#### Ver estado de un dispositivo

```http
  GET admin/check_device_status
```
Body
```http
{
    "device": {
        "id": id_device,
        "type": ["pos"|"printer"|"red_service"]
    }
    
}
```

#### Modificar el estado de un dispositivo

```http
  PATCH admin/update_device_status
```
Body
```
{
    "device": {
        "id": id_device,
        "type": ["pos"|"printer"|"red_service"],
        "status": [0|1|2]
    }
    
}

//0 = activo, 1 = interrumpido, 2 = apagado
```

#### Obtener PoS actuales (Cola asincrónica)

```http
  GET device/show_pos_job
```

#### Obtener Impresoras actuales (Cola asincrónica)

```http
  GET device/show_printers_job
```

#### Obtener sistemas de redes actuales (Cola asincrónica)

```http
  GET device/show_red_systems_job
```

## Consideraciones para endpoints asincrónicos

 - Para visualizar qué contenido muestran los endpoints asincrónicos, es necesario que el cron se haya ejecutado, al menos, una vez. Sólo así se podrá visualizar la información requerida (esto es válido tanto como para consultas vía curl, Postman y desde el frontend en React.js).