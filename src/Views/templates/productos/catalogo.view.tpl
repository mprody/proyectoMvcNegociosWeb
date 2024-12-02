<style>
    <style>
        .cards{
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            width: 100%;
        }

        body {
            font-family: Arial, sans-serif;
            display: flex;
            flex-wrap: wrap; /* Permite que las tarjetas se acomoden en varias filas */
            justify-content: center;
            align-items: flex-start; /* Alinea las tarjetas al principio */
            height: auto; /* Permite que el alto sea dinámico */
            background-color: #f4f4f4;
            padding: 20px; /* Agrega un poco de espacio alrededor */
        }
        .card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.507);
            width: 300px;
            margin: 15px; /* Espaciado entre las tarjetas */
            overflow: hidden;
            text-align: center;
        }
        .card img {
            width: 100%;
            height: auto;
        }
        .card-content {
            padding: 16px;
        }
        .card-title {
            font-size: 1.5em;
            margin: 0;
        }
        .card-description {
            color: #666;
            margin: 8px 0;
        }
        .card-price {
            font-size: 1.2em;
            color: #333;
            margin: 8px 0;
        }
        .add-to-cart {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .add-to-cart:hover {
            background-color: #218838;
        }
    </style>
</style>
<section class="cards">
    <div class="row">
        {{foreach productos}}
            <div class="card">
            <img src="https://via.placeholder.com/300x200" alt="<?= htmlspecialchars($producto['nombre']) ?>">
                <div class="card-content">
                    <h2 class="card-title">{{nombreProducto}}</h2>
                    <p class="card-price">L.{{precioVenta}}</p>
                    <button class="add-to-cart">Agregar al Carrito</button>
                </div>
            </div>
        {{endfor productos}}

    </div>
</section>
