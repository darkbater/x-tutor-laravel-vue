    <nav class="menu">
	<ul class="menu-list">
            <li class="menu-item"><div class="menu-item-round"></div><a class="menu-item" href="{{ route('home') }}"> [ Главная ] </a></li>
            <li class="menu-item"><div class="menu-item-round"></div><a class="menu-item" href="{{ route('tutor') }}"> [ Учитель ] </a></li>
        </ul>

        <!-- Блок аутентификации -->
        <div class="auth-block">
			@guest
			<!-- Если пользователь не аутентифицирован, показываем форму входа -->
			<form method="POST" action="{{ route('login') }}">
				@csrf
				<input type="text" name="login" placeholder="E-mail или телефон" required>
				<input type="password" name="password" placeholder="Пароль" required>
				<button type="submit">Войти</button>
				<a href="{{ route('register') }}">Регистрация</a>
			</form>
            @else
			<!-- Если пользователь аутентифицирован, показываем приветствие и кнопку выхода -->
			<p>Привет, {{ Auth::user()->name }}!</p>
			<form method="POST" action="{{ route('logout') }}">
                    @csrf
                    <button type="submit">Выйти</button>
                </form>
            @endguest
        </div>
    </nav>
