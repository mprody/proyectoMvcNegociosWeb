<div class="hero-section">
    <div class="hero-content">
        <h1>Bienvenido a {{SITE_TITLE}}</h1>
        <p>Tu ferretería de confianza: Calidad, variedad y el mejor servicio</p>
        <a href="index.php?page=productos-catalogo" class="cta-button">Ver Catálogo</a>
    </div>
</div>

<section class="features">
    <div class="feature-item">
        <i class="fas fa-truck"></i>
        <h3>Envío Gratis</h3>
        <p>En compras mayores a L.1000</p>
    </div>
    <div class="feature-item">
        <i class="fas fa-shield-alt"></i>
        <h3>Compra Segura</h3>
        <p>Garantía en todos los productos</p>
    </div>
    <div class="feature-item">
        <i class="fas fa-headset"></i>
        <h3>Soporte 24/7</h3>
        <p>Atención personalizada</p>
    </div>
</section>

<section class="products-section">
    <h2>Ofertas del Día</h2>
    <div class="product-grid">
        {{foreach productsOnSale}}
        <div class="product-card">
            <span class="sale-badge">Oferta</span>
            <img src="https://via.placeholder.com/300x200" alt="{{nombreProducto}}">
            <h3>{{nombreProducto}}</h3>
            <div class="price">
                <span class="current-price">L. {{precioVenta}}</span>
                <span class="original-price">L. {{precioOriginal}}</span>
            </div>
            <button onclick="window.location.href='index.php?page=productos-catalogo'">
                Ver Detalles
            </button>
        </div>
        {{endfor productsOnSale}}
    </div>

    <h2>Productos Destacados</h2>
    <div class="product-grid">
        {{foreach productsHighlighted}}
        <div class="product-card">
            <img src="https://via.placeholder.com/300x200" alt="{{nombreProducto}}">
            <h3>{{nombreProducto}}</h3>
            <div class="price">L. {{precioVenta}}</div>
            <button onclick="window.location.href='index.php?page=productos-catalogo'">
                Ver Detalles
            </button>
        </div>
        {{endfor productsHighlighted}}
    </div>

    <h2>Nuevos Productos</h2>
    <div class="product-grid">
        {{foreach productsNew}}
        <div class="product-card">
            <span class="new-badge">Nuevo</span>
            <img src="https://via.placeholder.com/300x200" alt="{{nombreProducto}}">
            <h3>{{nombreProducto}}</h3>
            <div class="price">L. {{precioVenta}}</div>
            <button onclick="window.location.href='index.php?page=productos-catalogo'">
                Ver Detalles
            </button>
        </div>
        {{endfor productsNew}}
    </div>
</section>

<style>
    .hero-section {
        background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://via.placeholder.com/1920x600');
        background-size: cover;
        background-position: center;
        color: white;
        text-align: center;
        padding: 100px 20px;
        margin-bottom: 40px;
    }

    .hero-content {
        max-width: 800px;
        margin: 0 auto;
    }

    .hero-content h1 {
        font-size: 3em;
        margin-bottom: 20px;
    }

    .cta-button {
        display: inline-block;
        padding: 15px 30px;
        background-color: var(--accent-color);
        color: white;
        text-decoration: none;
        border-radius: 5px;
        margin-top: 20px;
        transition: background-color 0.3s;
    }

    .cta-button:hover {
        background-color: #e5a61d;
    }

    .features {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 30px;
        padding: 40px 20px;
        background: var(--light-gray);
        margin-bottom: 40px;
    }

    .feature-item {
        text-align: center;
        padding: 20px;
    }

    .feature-item i {
        font-size: 2.5em;
        color: var(--primary-color);
        margin-bottom: 15px;
    }

    .products-section {
        padding: 20px;
    }

    .products-section h2 {
        text-align: center;
        margin: 40px 0 20px;
        color: var(--primary-color);
    }

    .product-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
        gap: 20px;
        margin-bottom: 40px;
    }

    .product-card {
        background: white;
        border-radius: 8px;
        padding: 15px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        transition: transform 0.3s;
        position: relative;
    }

    .product-card:hover {
        transform: translateY(-5px);
    }

    .product-card img {
        width: 100%;
        height: 200px;
        object-fit: cover;
        border-radius: 4px;
    }

    .product-card h3 {
        margin: 15px 0;
        font-size: 1.1em;
        height: 2.4em;
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
    }

    .price {
        display: flex;
        align-items: center;
        gap: 10px;
        margin: 10px 0;
    }

    .current-price {
        color: var(--primary-color);
        font-weight: bold;
        font-size: 1.2em;
    }

    .original-price {
        text-decoration: line-through;
        color: #666;
        font-size: 0.9em;
    }

    .sale-badge, .new-badge {
        position: absolute;
        top: 10px;
        right: 10px;
        padding: 5px 10px;
        border-radius: 3px;
        color: white;
        font-size: 0.9em;
        font-weight: bold;
    }

    .sale-badge {
        background-color: #e53e3e;
    }

    .new-badge {
        background-color: #38a169;
    }

    .product-card button {
        width: 100%;
        padding: 10px;
        background-color: var(--primary-color);
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        margin-top: 15px;
        transition: background-color 0.3s;
        font-weight: 500;
    }

    .product-card button:hover {
        background-color: var(--secondary-color);
    }

    @media (max-width: 768px) {
        .hero-content h1 {
            font-size: 2em;
        }

        .hero-content p {
            font-size: 1.1em;
        }

        .features {
            grid-template-columns: 1fr;
        }

        .product-grid {
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
        }
    }

    @media (max-width: 480px) {
        .hero-section {
            padding: 60px 20px;
        }

        .hero-content h1 {
            font-size: 1.8em;
        }

        .product-card h3 {
            font-size: 1em;
        }
    }
</style>