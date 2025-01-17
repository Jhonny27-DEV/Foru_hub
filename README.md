# Challenge Foro GitHub: Desafío Back End con Java Spring Boot, Spring Security, Spring Data JPA y PostgreSQL

## Desafío Alura Latam - Oracle One: Challenge Back End
Bienvenido al **Challenge Foro GitHub**, una aplicación de foro diseñada para gestionar tópicos, usuarios y respuestas, 
utilizando **Java Spring Boot** y **Spring Security**. Esta aplicación se conecta a una base de datos **PostgreSQL** y
expone una **API REST** para realizar operaciones completas.

---

## Funcionalidades de la API
- **Crear un nuevo tópico:** Permite a los usuarios registrados crear nuevos tópicos con título, mensaje y asociación a un curso.
- **Listar todos los tópicos creados:** Proporciona una lista paginada y filtrada de todos los tópicos registrados en la base de datos.
- **Mostrar un tópico específico:** Devuelve los detalles de un tópico identificado por su ID.
- **Actualizar un tópico:** Permite modificar la información de un tópico existente, como el título y el mensaje.
- **Eliminar un tópico:** Realiza una eliminación lógica mediante un atributo `is_deleted`, garantizando la integridad de los datos.
- **Gestín de usuarios:** Registro, autenticación y autorización de usuarios mediante **JWT**.

---

## Objetivos del Challenge
- Diseñar e implementar una **API REST** siguiendo las mejores prácticas.
- Realizar validaciones según las reglas de negocio, asegurando consistencia y seguridad.
- Gestionar una base de datos relacional (**PostgreSQL**) con migraciones automáticas mediante **Flyway**.
- Implementar un sistema de autenticación y autorización utilizando **JWT**.
- Seguir principios de desarrollo ágil y documentar adecuadamente el proyecto.

---

## Tecnologías Utilizadas
- **Lenguaje:** Java 17
- **Frameworks:** Spring Boot, Spring Security, Spring Data JPA
- **Base de datos:** PostgreSQL
- **Migraciones:** Flyway
- **Validación:** Bean Validation (javax.validation)
- **Herramientas externas:**
   - **GitHub:** Control de versiones.
   - **Trello:** Gestín de tareas y organización ágil.
   - **Insomnia/Postman:** Pruebas de los endpoints de la API.
   - **IntelliJ IDEA:** Entorno de desarrollo integrado.

---

## Arquitectura del Proyecto
El proyecto sigue una estructura de capas para garantizar la escalabilidad y mantenibilidad:

1. **Controladores (Controllers):** Manejan las solicitudes HTTP y devuelven respuestas en formato JSON.
2. **Servicios (Services):** Contienen la lógica de negocio principal.
3. **Repositorios (Repositories):** Gestionan la interacción con la base de datos mediante Spring Data JPA.
4. **Modelos (Entities):** Representan las tablas de la base de datos.
5. **Configuración:** Archivos y clases de configuración, como `SecurityConfig` y `application.properties`.

---

## Estructura de la Base de Datos

### Tablas principales:

1. **Usuario**
   - `id` (UUID, PK)
   - `email` (VARCHAR, único)
   - `contraseña` (VARCHAR)

2. **Tópico**
   - `id` (UUID, PK)
   - `titulo` (VARCHAR)
   - `mensaje` (TEXT)
   - `fecha_creacion` (TIMESTAMP)
   - `curso_id` (FK a Curso)
   - `usuario_id` (FK a Usuario)
   - `is_deleted` (BOOLEAN)

3. **Respuesta**
   - `id` (UUID, PK)
   - `mensaje` (TEXT)
   - `fecha_creacion` (TIMESTAMP)
   - `topico_id` (FK a Tópico)
   - `usuario_id` (FK a Usuario)

4. **Curso**
   - `id` (UUID, PK)
   - `nombre` (VARCHAR)
   - `categoria` (VARCHAR)

---

## Configuración del Proyecto

### Variables de Entorno
Configura las siguientes variables de entorno para la conexión con PostgreSQL:

```properties
spring.datasource.url=jdbc:postgresql://${DB_HOST}:${DB_PORT}/${DB_NAME}
spring.datasource.username=${DB_USER}
spring.datasource.password=${DB_PASS}
spring.jpa.hibernate.ddl-auto=validate
spring.flyway.enabled=true
spring.flyway.locations=classpath:db/migration
jwt.secret=${JWT_SECRET}

```

### Ejecución de Migraciones
Utiliza Flyway para gestionar las migraciones de la base de datos. Crea tus scripts en la carpeta `src/main/resources/db/migration` con la nomenclatura `V1__inicial.sql`.

Ejemplo de script de migración inicial:
```sql
CREATE TABLE usuario (
    id UUID PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(255) NOT NULL,
    rol VARCHAR(10) NOT NULL
);

CREATE TABLE topico (
    id UUID PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    mensaje TEXT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    curso_id UUID REFERENCES curso(id),
    usuario_id UUID REFERENCES usuario(id),
    is_deleted BOOLEAN DEFAULT FALSE
);
```

### Configuración de Seguridad
La autenticación y autorización se manejan mediante **JWT**. Asegúrate de configurar un filtro para validar los tokens en cada solicitud:

```java
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable()
            .authorizeRequests()
            .antMatchers("/api/auth/**").permitAll()
            .anyRequest().authenticated()
            .and()
            .addFilter(new JwtAuthenticationFilter(authenticationManager()))
            .addFilter(new JwtAuthorizationFilter(authenticationManager()));
    }
}
```

---

## Pruebas de la API
Utiliza **Insomnia** o **Postman** para probar los endpoints de la API. Ejemplo de prueba para crear un tópico:

### Endpoint: Crear Tópico
- **URL:** `POST /api/topicos`
- **Headers:**
   - `Authorization: Bearer <token>`
- **Body (JSON):**
```json
{
    "titulo": "¿Cómo usar Spring Boot?",
    "mensaje": "Quiero aprender a configurar Spring Boot con PostgreSQL.",
    "curso_id": "<UUID del curso>"
}
```
- **Respuesta (201 Created):**
```json
{
    "id": "<UUID>",
    "titulo": "¿Cómo usar Spring Boot?",
    "mensaje": "Quiero aprender a configurar Spring Boot con PostgreSQL.",
    "fecha_creacion": "2025-01-16T10:00:00Z",
    "curso_id": "<UUID del curso>",
    "usuario_id": "<UUID del usuario>"
}
```

---

## Creado por:
- **Jhonny Rosario**
- **Formación:** Java Orientado a Objetos G7 - ONE
- **Organización:** Alura Latam y Oracle Next Education


