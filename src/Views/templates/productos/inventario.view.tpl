
<h1>Inventario</h1>

{{if hasProductos}}
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
                            <a href="index.php?page=products-rolesForm&mode=UPD&rolescod={{rolescod}}"> 
                                <i class="fa-solid fa-file-pen"></i>
                            </a>
                            <a href="index.php?page=products-rolesForm&mode=DEL&rolescod={{rolescod}}">
                                <i class="fa-solid fa-trash"></i>
                            </a>
                            <a href="index.php?page=products-rolesForm&mode=DSP&rolescod={{rolescod}}">
                                <i class="fa-solid fa-eye"></i>
                            </a>
                        </td>
                    </tr>
                {{endfor productos}}
            </tbody>
        </table>
    </section>
{{else}}
    <div class="no-records">
        <a href="index.php?page=products-rolesForm&mode=INS" class="btn-add">
            <i class="fa-solid fa-plus"></i> Agregar Producto
        </a>
    </div>
{{endif hasProductos}}

<style>
    .alert {
        padding: 1rem;
        margin-bottom: 1rem;
        border-radius: 4px;
    }
    
    .alert-danger {
        background-color: #fee2e2;
        color: #dc2626;
        border: 1px solid #fecaca;
    }
    
    .no-records {
        text-align: center;
        padding: 2rem;
        background: #f9fafb;
        border-radius: 8px;
        margin: 1rem 0;
    }
    
    .btn-add {
        display: inline-block;
        padding: 0.5rem 1rem;
        background: #2563eb;
        color: white;
        text-decoration: none;
        border-radius: 4px;
        margin-top: 1rem;
    }
    
    .btn-add:hover {
        background: #1d4ed8;
    }
</style>