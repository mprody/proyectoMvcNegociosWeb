<h1>Inventario</h1>
<section class="WWList">
    <table>
        <thead>
            <tr>
                <th>Codigo</th>
                <th>Categoria</th>
                <th>Proveedor</th>
                <th>Nombre Producto</th>
                <th>Stock</th>
                <th>Precio de venta</th>
                <th>Precio de compra</th>
                <th>Fecha de compra</th>
                <th><a href="index.php?page=products-rolesForm&mode=INS"><i class="fa-solid fa-plus"></i></a></th>
            </tr>
        </thead>
        <tbody>
            {{foreach productos}}
                <tr>
                    <td>{{codProducto}}</td>
                    <td>{{CodCategoria}}</td>
                    <td>{{codProveedor}}</td>
                    <td>{{nombreProducto}}</td>
                    <td>{{Stock}}</td>
                    <td>{{precioVenta}}</td>
                    <td>{{precioCompra}}</td>
                    <td>{{fechaCompra}}</td>
                    <td style="display: flex; gap:1rem; justify-content:center; align-items:center;">
                        <a href="index.php?page=products-rolesForm&mode=UPD&rolescod={{rolescod}}"> <i class="fa-solid fa-file-pen"></i></a>
                        <a href="index.php?page=products-rolesForm&mode=DEL&rolescod={{rolescod}}"> <i class="fa-solid fa-trash"></i></i></a>
                        <a href="index.php?page=products-rolesForm&mode=DSP&rolescod={{rolescod}}"> <i class="fa-solid fa-eye"></i></a>
                    </td>
                </tr>
            {{endfor productos}}
        </tbody>
    </table>
</section>