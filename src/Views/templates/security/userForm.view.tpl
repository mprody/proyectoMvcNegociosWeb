<h1>{{modes_dsc}}</h1>
<section>
  {{with user}}
  <form action="index.php?page=Security_UserForm&mode={{~mode}}&usercod={{usercod}}" method="post">
    <input type="hidden" name="usercod" id="usercod_hidden" value="{{usercod}}">
    
    <div class="row">
      <div class="col-12 col-m-8 offset-m-2">
        <div class="row my-2">
          <label class="col-4" for="usercod_display">Código</label>
          <div class="col-8">
            <input type="text" readonly disabled name="usercod_display" id="usercod_display" value="{{usercod}}">
          </div>
        </div>

        <div class="row my-2">
          <label class="col-4" for="username">Nombre</label>
          <div class="col-8">
            <input type="text" {{~readonly}} name="username" id="username" value="{{username}}">
          </div>
        </div>

        <div class="row my-2">
          <label class="col-4" for="useremail">Email</label>
          <div class="col-8">
            <input type="email" {{~readonly}} name="useremail" id="useremail" value="{{useremail}}">
          </div>
        </div>

        {{if ~showPassw}}
        <div class="row my-2">
          <label class="col-4" for="userpswd">Contraseña</label>
          <div class="col-8">
            <input type="password" {{~readonly}} name="userpswd" id="userpswd">
          </div>
        </div>
        {{endif ~showPassw}}

        <div class="row my-2">
          <label class="col-4" for="userest">Estado</label>
          <div class="col-8">
            <select name="userest" id="userest" {{~readonly}}>
              <option value="ACT" {{userest_ACT}}>Activo</option>
              <option value="INA" {{userest_INA}}>Inactivo</option>
              <option value="BLQ" {{userest_BLQ}}>Bloqueado</option>
              <option value="SUS" {{userest_SUS}}>Suspendido</option>
            </select>
          </div>
        </div>

        <div class="row my-2">
          <label class="col-4" for="usertipo">Tipo</label>
          <div class="col-8">
            <select name="usertipo" id="usertipo" {{~readonly}}>
              <option value="PBL" {{usertipo_PBL}}>Público</option>
              <option value="ADM" {{usertipo_ADM}}>Administrador</option>
              <option value="AUD" {{usertipo_AUD}}>Auditor</option>
            </select>
          </div>
        </div>

        <div class="row my-4">
          <div class="col-12 right">
            {{if ~showCommit}}
              <button type="submit" class="btn primary">Confirmar</button>
              &nbsp;
              <button type="button" id="btnCancelar" class="btn">Cancelar</button>
            {{endif ~showCommit}}
            {{ifnot ~showCommit}}
              <button type="button" id="btnCancelar" class="btn">Regresar</button>
            {{endifnot ~showCommit}}
          </div>
        </div>
      </div>
    </div>
  </form>
  {{endwith user}}
</section>

<script>
  document.addEventListener("DOMContentLoaded", function() {
    document.getElementById("btnCancelar").addEventListener("click", function(e) {
      e.preventDefault();
      e.stopPropagation();
      window.location.assign("index.php?page=Security_UsersList");
    });
  });
</script>