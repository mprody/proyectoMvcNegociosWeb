<style>
    .cart-container {
        max-width: 1000px;
        margin: 30px auto;
        padding: 20px;
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }

    .cart-container h1 {
        text-align: center;
        margin-bottom: 30px;
        color: #333;
    }

    .cart-table {
        width: 100%;
        border-collapse: collapse;
    }

    .cart-table thead {
        background-color: #f5f5f5;
    }

    .cart-table th, .cart-table td {
        padding: 15px;
        border-bottom: 1px solid #ddd;
        text-align: center;
    }

    .cart-table th {
        color: #555;
    }

    .cart-table td {
        color: #333;
    }

    .cart-total {
        text-align: right;
        margin-top: 20px;
        font-weight: bold;
        font-size: 1.2em;
        color: #e67e22;
    }

    .btn {
        padding: 10px 20px;
        border: none;
        cursor: pointer;
        font-size: 1em;
        font-weight: 500;
        transition: background-color 0.3s;
        border-radius: 4px; /* Radio de borde por defecto para botones */
    }

    .btn-remove {
        background-color: #e74c3c;
        color: white;
    }

    .btn-remove:hover {
        background-color: #c0392b;
    }

    .btn-clear {
        background-color: #95a5a6;
        color: white;
    }

    .btn-clear:hover {
        background-color: #7f8c8d;
    }

    .btn-checkout {
        background-color: #27ae60;
        color: white;
        border-radius: 0; /* Hacemos el botón rectangular */
    }

    .btn-checkout:hover {
        background-color: #219150;
    }

    .cart-actions {
        display: flex;
        justify-content: space-between;
        margin-top: 30px;
    }

    @media (max-width: 768px) {
        .cart-actions {
            flex-direction: column;
            align-items: stretch;
        }

        .cart-actions .btn {
            margin-bottom: 10px;
            width: 100%;
        }

        .cart-table th, .cart-table td {
            padding: 10px;
        }
    }
</style>

<div class="cart-container">
    <h1>Carrito de Compras</h1>

    <table class="cart-table">
        <thead>
            <tr>
                <th>Producto</th>
                <th>Precio Unitario</th>
                <th>Cantidad</th>
                <th>Subtotal</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            {{foreach cart}}
            <tr>
                <td>{{name}}</td>
                <td>L. {{price}}</td>
                <td>{{quantity}}</td>
                <td>L. {{total}}</td>
                <td>
                    <button class="btn btn-remove" onclick="removeFromCart({{id}})">
                        Eliminar
                    </button>
                </td>
            </tr>
            {{endfor cart}}
        </tbody>
    </table>

    <div class="cart-total">
        Total a Pagar: L. {{cartTotal}}
    </div>

    <div class="cart-actions">
        <button class="btn btn-clear" onclick="clearCart()">Limpiar Carrito</button>
        <a href="index.php?page=checkout" class="btn btn-checkout">Proceder al Pago</a>
    </div>
</div>

<script>
function removeFromCart(productId) {
    if (!confirm('¿Está seguro de eliminar este producto?')) return;

    fetch('index.php?page=Cart_Cart', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: new URLSearchParams({
            action: 'remove',
            productId: productId
        })
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === 'SUCCESS') {
            location.reload();
        } else {
            alert(data.message || 'Error al eliminar el producto');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Error al eliminar el producto');
    });
}

function clearCart() {
    if (!confirm('¿Está seguro de limpiar el carrito?')) return;

    fetch('index.php?page=Cart_Cart', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: new URLSearchParams({
            action: 'clear'
        })
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === 'SUCCESS') {
            location.reload();
        } else {
            alert(data.message || 'Error al limpiar el carrito');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Error al limpiar el carrito');
    });
}
</script>
