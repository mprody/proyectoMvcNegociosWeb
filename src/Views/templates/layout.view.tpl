
<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>{{SITE_TITLE}}</title>
   <link rel="preconnect" href="https://fonts.gstatic.com">
   <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
   <link rel="stylesheet" href="/{{BASE_DIR}}/public/css/appstyle.css" />
   <script src="https://kit.fontawesome.com/{{FONT_AWESOME_KIT}}.js" crossorigin="anonymous"></script>
   {{foreach SiteLinks}}
       <link rel="stylesheet" href="/{{~BASE_DIR}}/{{this}}" />
   {{endfor SiteLinks}}
   {{foreach BeginScripts}}
       <script src="/{{~BASE_DIR}}/{{this}}"></script>
   {{endfor BeginScripts}}
   <style>
       :root {
           --primary-color: #1a457b;
           --secondary-color: #2c5282;
           --accent-color: #f7b731;
           --text-color: #2d3748;
           --light-gray: #f7fafc;
           --border-color: #e2e8f0;
       }

       body {
           font-family: 'Roboto', sans-serif;
           margin: 0;
           padding-top: 70px;
           color: var(--text-color);
           min-height: 100vh;
           display: flex;
           flex-direction: column;
       }

       .navbar {
           background-color: var(--primary-color);
           position: fixed;
           top: 0;
           left: 0;
           right: 0;
           height: 70px;
           display: flex;
           align-items: center;
           box-shadow: 0 2px 4px rgba(0,0,0,0.1);
           z-index: 1000;
       }

       .navbar-container {
           max-width: 1200px;
           margin: 0 auto;
           display: flex;
           align-items: center;
           justify-content: space-between;
           padding: 0 2rem;
           width: 100%;
       }

       .navbar-brand {
           display: flex;
           align-items: center;
           gap: 1rem;
           text-decoration: none;
       }

       .navbar-brand img {
           width: 40px;
           height: 40px;
       }

       .navbar-brand h1 {
           color: white;
           margin: 0;
           font-size: 1.5rem;
       }

       .navbar-menu {
           display: flex;
           align-items: center;
           gap: 2rem;
           margin: 0;
           padding: 0;
           list-style: none;
       }

       .navbar-menu a {
           color: white;
           text-decoration: none;
           font-weight: 500;
           padding: 0.5rem 1rem;
           border-radius: 4px;
           transition: all 0.3s ease;
       }

       .navbar-menu a:hover {
           background-color: var(--secondary-color);
           transform: translateY(-2px);
       }

       .navbar-actions {
           display: flex;
           align-items: center;
           gap: 1rem;
       }

       .cart-button {
           position: relative;
           color: white;
           text-decoration: none;
           padding: 0.5rem;
       }

       .cart-count {
           position: absolute;
           top: -5px;
           right: -5px;
           background-color: var(--accent-color);
           color: var(--primary-color);
           border-radius: 50%;
           padding: 2px 6px;
           font-size: 0.8rem;
           font-weight: bold;
       }

       main {
           flex: 1;
           max-width: 1200px;
           margin: 0 auto;
           padding: 2rem;
           width: 100%;
           box-sizing: border-box;
       }

       footer {
           background-color: var(--primary-color);
           color: white;
           padding: 3rem 0;
           margin-top: auto;
       }

       .footer-container {
           max-width: 1200px;
           margin: 0 auto;
           display: grid;
           grid-template-columns: repeat(4, 1fr);
           gap: 2rem;
           padding: 0 2rem;
       }

       .footer-section h3 {
           color: var(--accent-color);
           margin-bottom: 1rem;
           font-size: 1.2rem;
       }

       .footer-section ul {
           list-style: none;
           padding: 0;
           margin: 0;
       }

       .footer-section li {
           margin-bottom: 0.5rem;
       }

       .footer-section a {
           color: white;
           text-decoration: none;
           transition: color 0.3s ease;
       }

       .footer-section a:hover {
           color: var(--accent-color);
       }

       .footer-bottom {
           text-align: center;
           padding-top: 2rem;
           margin-top: 2rem;
           border-top: 1px solid rgba(255,255,255,0.1);
       }

       .icon {
           margin-right: 0.5rem;
       }
   </style>
</head>
<body>
   <nav class="navbar">
       <div class="navbar-container">
           <a href="index.php?page={{PUBLIC_DEFAULT_CONTROLLER}}" class="navbar-brand">
               <img src="https://via.placeholder.com/40" alt="Logo Ferretería">
               <h1>{{SITE_TITLE}}</h1>
           </a>
           
<ul class="navbar-menu">
    <li>
        <a href="index.php?page={{PUBLIC_DEFAULT_CONTROLLER}}">
            <i class="fas fa-home icon"></i>Inicio
        </a>
    </li>
    <li>
        <a href="index.php?page=Sec_Login">
            <i class="fas fa-sign-in-alt"></i>&nbsp;Iniciar Sesión
        </a>
    </li>
    <li>
        <a href="index.php?page=Sec_Register">
            <i class="fas fa-user-plus"></i>&nbsp;Crear Cuenta
        </a>
    </li>
    <li>
        <a href="index.php?page=productos-inventario">
            <i class="fas fa-boxes"></i>&nbsp;Inventario
        </a>
    </li>
    <li>
        <a href="index.php?page=productos-catalogo">
            <i class="fas fa-store"></i>&nbsp;Catálogo
        </a>
    </li>
    <li>
        <a href="index.php?page=Products-rolesList">
            <i class="fas fa-user-tag"></i>&nbsp;Roles
        </a>
    </li>
    <li>
        <a href="index.php?page=Security-UsersList">
            <i class="fas fa-users"></i>&nbsp;Usuarios
        </a>
    </li>
    <li>
        <a href="index.php?page=Funciones-FuncionesList">
            <i class="fas fa-cogs"></i>&nbsp;Funciones
        </a>
    </li>
</ul>

           <div class="navbar-actions">
               <a href="index.php?page=Cart-Cart" class="cart-button">
                   <i class="fas fa-shopping-cart fa-lg"></i>
                   {{if cartItemCount}}
                       <span class="cart-count">{{cartItemCount}}</span>
                   {{endif cartItemCount}}
               </a>
           </div>
       </div>
   </nav>

   <main>
       {{{page_content}}}
   </main>

   <footer>
       <div class="footer-container">
           <div class="footer-section">
               <h3>Nuestra Empresa</h3>
               <ul>
                   <li><a href="#">Sobre Nosotros</a></li>
                   <li><a href="#">Misión y Visión</a></li>
                   <li><a href="#">Trabaja con Nosotros</a></li>
               </ul>
           </div>
           <div class="footer-section">
               <h3>Servicios</h3>
               <ul>
                   <li><a href="#">Catálogo de Productos</a></li>
                   <li><a href="#">Marcas</a></li>
                   <li><a href="#">Ofertas Especiales</a></li>
               </ul>
           </div>
           <div class="footer-section">
               <h3>Atención al Cliente</h3>
               <ul>
                   <li><a href="#">Contacto</a></li>
                   <li><a href="#">Preguntas Frecuentes</a></li>
                   <li><a href="#">Políticas de Devolución</a></li>
               </ul>
           </div>
           <div class="footer-section">
               <h3>Contacto</h3>
               <ul>
                   <li><i class="fas fa-phone icon"></i> (504) 2222-2222</li>
                   <li><i class="fas fa-envelope icon"></i> info@ferreteria.com</li>
                   <li><i class="fas fa-map-marker-alt icon"></i> Tegucigalpa, Honduras</li>
               </ul>
           </div>
       </div>
       <div class="footer-bottom">
           <div>Todos los Derechos Reservados {{~CURRENT_YEAR}} &copy; {{SITE_TITLE}}</div>
       </div>
   </footer>

   {{foreach EndScripts}}
       <script src="/{{~BASE_DIR}}/{{this}}"></script>
   {{endfor EndScripts}}
</body>
</html>