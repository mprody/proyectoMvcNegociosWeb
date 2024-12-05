
<div class="register-container">
    <div class="register-card">
        <div class="register-header">
            <i class="fas fa-user-plus"></i>
            <h1>Crear Cuenta</h1>
        </div>
        
        <form method="post" action="index.php?page=sec_register" class="register-form">
            <div class="form-group">
                <label for="txtEmail">
                    <i class="fas fa-envelope"></i> Correo Electrónico
                </label>
                <input 
                    type="email" 
                    id="txtEmail" 
                    name="txtEmail" 
                    value="{{txtEmail}}"
                    placeholder="ejemplo@correo.com"
                    required
                />
                {{if errorEmail}}
                    <div class="error-message">
                        <i class="fas fa-exclamation-circle"></i> {{errorEmail}}
                    </div>
                {{endif errorEmail}}
            </div>

            <div class="form-group">
                <label for="txtPswd">
                    <i class="fas fa-lock"></i> Contraseña
                </label>
                <div class="password-input">
                    <input 
                        type="password" 
                        id="txtPswd" 
                        name="txtPswd" 
                        value="{{txtPswd}}"
                        placeholder="Cree una contraseña segura"
                        required
                    />
                    <button type="button" class="toggle-password" onclick="togglePassword()">
                        <i class="fas fa-eye"></i>
                    </button>
                </div>
                {{if errorPswd}}
                    <div class="error-message">
                        <i class="fas fa-exclamation-circle"></i> {{errorPswd}}
                    </div>
                {{endif errorPswd}}
            </div>

            <button type="submit" class="register-button" id="btnSignin">
                <i class="fas fa-user-plus"></i> Crear Cuenta
            </button>

            <div class="register-footer">
                <a href="index.php?page=Sec_Login" class="login-link">
                    <i class="fas fa-sign-in-alt"></i> ¿Ya tienes cuenta? Inicia Sesión
                </a>
            </div>
        </form>
    </div>
</div>

<style>
    .register-container {
        min-height: calc(100vh - 200px);
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
    }

    .register-card {
        background: white;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 400px;
        padding: 2rem;
    }

    .register-header {
        text-align: center;
        margin-bottom: 2rem;
    }

    .register-header i {
        font-size: 3rem;
        color: var(--primary-color);
        margin-bottom: 1rem;
    }

    .register-header h1 {
        color: var(--primary-color);
        font-size: 1.8rem;
        margin: 0;
    }

    .form-group {
        margin-bottom: 1.5rem;
    }

    .form-group label {
        display: block;
        margin-bottom: 0.5rem;
        color: var(--text-color);
        font-weight: 500;
    }

    .form-group input {
        width: 100%;
        padding: 0.75rem;
        border: 2px solid var(--border-color);
        border-radius: 6px;
        font-size: 1rem;
        transition: border-color 0.3s ease;
    }

    .form-group input:focus {
        border-color: var(--primary-color);
        outline: none;
    }

    .password-input {
        position: relative;
    }

    .toggle-password {
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        background: none;
        border: none;
        color: var(--text-color);
        cursor: pointer;
        padding: 0.5rem;
    }

    .error-message {
        color: #e53e3e;
        font-size: 0.875rem;
        margin-top: 0.5rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .register-button {
        width: 100%;
        padding: 0.875rem;
        background-color: var(--primary-color);
        color: white;
        border: none;
        border-radius: 6px;
        font-size: 1rem;
        font-weight: 500;
        cursor: pointer;
        transition: background-color 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
        margin-top: 1rem;
    }

    .register-button:hover {
        background-color: var(--secondary-color);
    }

    .register-footer {
        margin-top: 1.5rem;
        text-align: center;
    }

    .login-link {
        color: var(--primary-color);
        text-decoration: none;
        font-weight: 500;
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        transition: color 0.3s ease;
    }

    .login-link:hover {
        color: var(--secondary-color);
    }

    @media (max-width: 480px) {
        .register-card {
            padding: 1.5rem;
        }

        .register-header i {
            font-size: 2.5rem;
        }

        .register-header h1 {
            font-size: 1.5rem;
        }
    }
</style>

<script>
    function togglePassword() {
        const passwordInput = document.getElementById('txtPswd');
        const toggleButton = document.querySelector('.toggle-password i');
        
        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            toggleButton.classList.remove('fa-eye');
            toggleButton.classList.add('fa-eye-slash');
        } else {
            passwordInput.type = 'password';
            toggleButton.classList.remove('fa-eye-slash');
            toggleButton.classList.add('fa-eye');
        }
    }
</script>