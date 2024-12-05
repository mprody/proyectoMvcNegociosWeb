<style>
    /* Estilos generales */
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f9f9f9;
        margin: 0;
        padding: 0;
    }

    h1 {
        text-align: center;
        margin-top: 30px;
        color: #333;
    }

    .product-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
        gap: 20px;
        padding: 20px;
        max-width: 1200px;
        margin: 0 auto;
    }

    .product-card {
        background: white;
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 15px;
        text-align: center;
        transition: transform 0.3s, box-shadow 0.3s;
        position: relative;
    }

    .product-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }

    .product-card h2 {
        font-size: 1.1rem;
        margin-bottom: 10px;
        color: #333;
        height: 2.4em;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .product-price {
        color: #e67e22;
        font-size: 1.2rem;
        font-weight: bold;
        margin: 10px 0;
    }

    .stock-info {
        color: #666;
        margin: 10px 0;
    }

    .product-actions {
        display: flex;
        gap: 10px;
        justify-content: center;
        align-items: center;
        margin-top: 15px;
    }

    .quantity-input {
        width: 60px;
        padding: 5px;
        text-align: center;
        border: 1px solid #ccc;
        border-radius: 4px;
    }

    /* Estilos del botón actualizado */
    .add-to-cart {
        background-color: #007BFF; /* Azul estándar */
        color: white;
        border: none;
        padding: 10px 15px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 0.9rem;
        transition: background-color 0.3s;
    }

    .add-to-cart:hover {
        background-color: #0069D9; /* Azul más oscuro al pasar el cursor */
    }

    .product-card img {
        width: 100%;
        height: auto;
        max-height: 150px;
        object-fit: cover;
        border-radius: 4px;
        margin-bottom: 10px;
    }

    /* Estilos para el contenedor de depuración */
    .debug-box {
        background: #f0f0f0;
        padding: 10px;
        margin: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 0.9rem;
        color: #333;
    }

    @media (max-width: 768px) {
        .product-grid {
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
        }
    }
</style>

<h1>Catálogo de Productos</h1>

<div class="product-grid">
    {{foreach productos}}
    <div class="product-card">
        <!-- Puedes reemplazar la imagen de placeholder por imágenes reales -->
        <img src="https://via.placeholder.com/300x200" alt="{{nombreProducto}}">
        <h2 class="product-title">{{nombreProducto}}</h2>
        <p class="product-price">L. {{precioVenta}}</p>
        <p class="stock-info">Stock: {{Stock}} unidades</p>
        
        <div class="product-actions">
            <input type="number" 
                   class="quantity-input"
                   value="1"
                   min="1"
                   max="{{Stock}}"
                   id="quantity_{{codProducto}}">
            <button 
                class="add-to-cart" 
                data-id="{{codProducto}}" 
                data-name="{{nombreProducto}}" 
                data-price="{{precioVenta}}" 
                data-stock="{{Stock}}">
                Agregar al Carrito
            </button>
        </div>
    </div>
    {{endfor productos}}
</div>

<!-- Opcional: Contenedor para mensajes de depuración -->
<!-- Puedes comentar o eliminar este div si no lo necesitas -->
<!-- <div id="debug-container"></div> -->

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Función showDebug permanece igual
    function showDebug(title, data) {
        const debugDiv = document.createElement('div');
        debugDiv.className = 'debug-box';
        debugDiv.innerHTML = `
            <h3>${title}</h3>
            <pre>${JSON.stringify(data, null, 2)}</pre>
        `;
        document.getElementById('debug-container').appendChild(debugDiv);
    }

    // El resto del código JavaScript permanece igual
    function addToCart(productId, name, price, maxStock, quantity) {
        if (isNaN(quantity) || quantity < 1) {
            alert('Por favor ingrese una cantidad válida');
            return;
        }

        if (quantity > maxStock) {
            alert(`Solo hay ${maxStock} unidades disponibles`);
            return;
        }

        const formData = new FormData();
        formData.append('action', 'add');
        formData.append('productId', productId);
        formData.append('name', name);
        formData.append('price', price);
        formData.append('quantity', quantity);

        fetch('index.php?page=Cart_Cart', {
            method: 'POST',
            headers: {
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'SUCCESS') {
                alert('Producto agregado al carrito');
            } else {
                alert(data.message || 'Error al agregar al carrito');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Error al agregar al carrito');
        });
    }

    // Asignar evento click a los botones de agregar al carrito
    document.querySelectorAll('.add-to-cart').forEach(button => {
        button.addEventListener('click', function() {
            const productId = this.getAttribute('data-id');
            const name = this.getAttribute('data-name');
            const price = this.getAttribute('data-price');
            const maxStock = parseInt(this.getAttribute('data-stock'));

            // Obtener la cantidad seleccionada
            const quantityInput = document.getElementById('quantity_' + productId);
            const quantity = parseInt(quantityInput.value);

            addToCart(productId, name, price, maxStock, quantity);
        });
    });

    // Validación de cantidades
    document.querySelectorAll('.quantity-input').forEach(input => {
        input.addEventListener('change', function() {
            const maxStock = parseInt(this.getAttribute('max'));
            const value = parseInt(this.value);

            if (value > maxStock) {
                this.value = maxStock;
                alert(`Solo hay ${maxStock} unidades disponibles`);
            } else if (value < 1) {
                this.value = 1;
                alert('La cantidad mínima es 1');
            }
        });
    });
});
</script>
