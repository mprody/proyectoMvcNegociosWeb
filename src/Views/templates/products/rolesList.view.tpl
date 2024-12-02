<h1>Listado de Roles</h1>
<section class="WWList">
    <table>
        <thead>
            <tr>
                <th>Codigo</th>
                <th>Descripcion del Rol</th>
                <th>Estado del Rol</th>
                <th><a href="index.php?page=products-rolesForm&mode=INS"><i class="fa-solid fa-plus"></i></a></th>
            </tr>
        </thead>
        <tbody>
            {{foreach roles}}
                <tr>
                    <td>{{rolescod}}</td>
                    <td>{{rolesdsc}}</td>
                    <td>{{rolesest}}</td>
                    <td style="display: flex; gap:1rem; justify-content:center; align-items:center;">
                        <a href="index.php?page=products-rolesForm&mode=UPD&rolescod={{rolescod}}"> <i class="fa-solid fa-file-pen"></i></a>
                        <a href="index.php?page=products-rolesForm&mode=DEL&rolescod={{rolescod}}"> <i class="fa-solid fa-trash"></i></i></a>
                        <a href="index.php?page=products-rolesForm&mode=DSP&rolescod={{rolescod}}"> <i class="fa-solid fa-eye"></i></a>
                    </td>
                </tr>
            {{endfor roles}}
        </tbody>
    </table>
</section>