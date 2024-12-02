<h1>Gestión de Usuarios</h1>
<section class="WWList">
    <table>
        <thead>
            <tr>
                <th>Código</th>
                <th>Correo</th>
                <th>Nombre</th>
                <th>Estado</th>
                <th>Tipo</th>
                <th><a href="index.php?page=Security_UserForm&mode=INS"><i class="fas fa-plus"></i></a></th>
            </tr>
        </thead>
        <tbody>
            {{foreach users}}
            <tr>
                <td>{{usercod}}</td>
                <td><a class="link" href="index.php?page=Security_UserForm&mode=DSP&usercod={{usercod}}">{{useremail}}</a></td>
                <td>{{username}}</td>
                <td>{{userest}}</td>
                <td>{{usertipo}}</td>
                <td class="center">
                    <a href="index.php?page=Security_UserForm&mode=UPD&usercod={{usercod}}">
                        <i class="fas fa-edit"></i>
                    </a>
                    <a href="index.php?page=Security_UserForm&mode=DEL&usercod={{usercod}}">
                        <i class="fas fa-trash"></i>
                    </a>
                    <a href="index.php?page=Security_UserForm&mode=DSP&usercod={{usercod}}">
                        <i class="fas fa-eye"></i>
                    </a>
                </td>
            </tr>
            {{endfor users}}
        </tbody>
    </table>
</section>