<h1>Carrito de Compras</h1>
<table border="1">
    <thead>
        <tr>
            <th>Producto</th>
            <th>Precio</th>
            <th>Cantidad</th>
            <th>Subtotal</th>
        </tr>
    </thead>
    <tbody>
        {{foreach productos}}
        <tr>
            <td>{{nombre}}</td>
            <td>L.{{precio}}</td>
            <td>{{cantidad}}</td>
            <td>L.{{precio * cantidad}}</td>
        </tr>
        {{endfor productos}}
    </tbody>
</table>
<h2>Total: L.{{total}}</h2>
<form method="post" action="index.php?page=CarritoController&action=pagar">
    <button type="submit">Pagar</button>
</form>
<a href="index.php?page=productos-catalogo">Volver al Catálogo</a>
