import 'package:base_widgets/data_providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

/// Экран счетчика
class CounterPage extends StatefulWidget {
  final String title;
  final int initialValue;

  const CounterPage({
    super.key,
    required this.title,
    required this.initialValue,
  });

  @override
  State<CounterPage> createState() => _CounterPageState();
}

/// Состояние экрана
class _CounterPageState extends State<CounterPage> {
  // Нам понадобятся:
  late final ThemeProvider _themeProvider; // для изменения фона
  late int _counter; // текущее состояние счетчика

  /// В этом методе делаем инициализацию необходимых свойств
  @override
  void initState() {
    super.initState();
    debugPrint('🟡 _CounterPageState старт initState()');

    // Присваиваем счетчику значение, которое получаем от родителя
    _counter = widget.initialValue;
    // Получаем провайдер темы
    _themeProvider = context.read<ThemeProvider>();
  }

  /// Вызывается 1 раз при создании стейта, а также при изменении зависимости
  /// данного объекта State. В разработке метод используется редко.
  ///
  /// Т.к. фон экрана зависит от темы, то при изменении темы будет вызван этот метод
  /// В разработке метод используется редко
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('🟡 _CounterPageState старт didChangeDependencies()');
  }

  /// Запускается отрисовка интерфейса
  @override
  Widget build(BuildContext context) {
    debugPrint('🟡 _CounterPageState старт build()');

    return Scaffold(
      // Когда мы нажмем в аппбаре кнопку Назад, то будут вызваны
      // методы deactivate() и dispose()
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 20),
            // Виджет с кнопками для счетчика
            _ActionsWidget(
              increment: _incrementCounter,
              clear: _clearCounter,
            ),
            const SizedBox(height: 100),
            // Анимированный виджет для демонстрации работы didUpdateWidget
            // Кнопками счетчика будем менять его конфигурацию
            _AnimatedBoxWidget(duration: _counter),
          ],
        ),
      ),
      // Кнопка для вызова окна палитры цветов
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _incrementCounter,
        label: TextButton.icon(
          onPressed: _showColorPicker,
          icon: const Icon(Icons.format_paint, color: Colors.white),
          label: const Text(
            'Цвет фона',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  /// Вызывается если была изменена конфигурация виджета
  @override
  void didUpdateWidget(covariant CounterPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('🟡 _CounterPageState старт didUpdateWidget()');
  }

  /// Состояние удаляется из дерева, но оно может быть повторно
  /// вставлено до завершения текущего изменения кадра
  @override
  void deactivate() {
    super.deactivate();
    debugPrint('🟡 _CounterPageState старт deactivate()');
  }

  /// Удаление стейта из дерева
  @override
  void dispose() {
    debugPrint('🟡 _CounterPageState старт dispose()');
    super.dispose();
  }

  /// Метод увеличения значения счетчика
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  /// Метод сброса значения счетчика до начального
  void _clearCounter() {
    setState(() {
      _counter = widget.initialValue;
    });
  }

  /// Метод вызова окна для смены фона экрана
  /// После изменений будут вызваны didChangeDependencies() и build()
  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.all(0),
          content: SingleChildScrollView(
            child: MaterialPicker(
              pickerColor: _themeProvider.pageBackground,
              onColorChanged: _themeProvider.changeThemeColor,
              enableLabel: true,
              portraitOnly: true,
            ),
          ),
        );
      },
    );
  }
}

/// Действия для счетчика
/// Изменяем значение счетчика, передаем в анимированный виджет
class _ActionsWidget extends StatelessWidget {
  final VoidCallback increment;
  final VoidCallback clear;

  const _ActionsWidget({
    Key? key,
    required this.increment,
    required this.clear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton.icon(
          onPressed: increment,
          icon: const Icon(Icons.add),
          label: const Text('Счетчик'),
        ),
        TextButton.icon(
          onPressed: clear,
          icon: const Icon(Icons.clear),
          label: const Text('Сбросить'),
        ),
      ],
    );
  }
}

/// Анимированный квадрат для демонстрации работы didUpdateWidget
/// Принимает значение из счетчика
class _AnimatedBoxWidget extends StatefulWidget {
  final int duration;

  const _AnimatedBoxWidget({required this.duration});

  @override
  __AnimatedBoxWidgetState createState() => __AnimatedBoxWidgetState();
}

/// Состояние анимированного квадрата
class __AnimatedBoxWidgetState extends State<_AnimatedBoxWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    debugPrint('🟢 __AnimatedBoxWidgetState старт initState()');

    _animationController = AnimationController(
      duration: Duration(seconds: widget.duration),
      vsync: this,
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('🟢 __AnimatedBoxWidgetState старт didChangeDependencies()');
  }

  /// Изменилась конфигурация виджета - необходимо внести изменения в наш контроллер
  @override
  void didUpdateWidget(covariant _AnimatedBoxWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('🟢 __AnimatedBoxWidgetState старт didUpdateWidget()');

    // Если конфигурация виджета была изменена, то мы должны задать новые параметры анимации
    // иначе ничего не изменится. Для проверки этого факта закомментируйте блок кода if
    if (oldWidget.duration != widget.duration) {
      _animationController.duration = Duration(seconds: widget.duration);
      _animationController.repeat(reverse: true);
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    debugPrint('🟢 __AnimatedBoxWidgetState старт deactivate()');
  }

  /// При удалении стейта из дерева не забудьте очистить ресурсы
  @override
  void dispose() {
    _animationController.dispose();
    debugPrint('🟢 __AnimatedBoxWidgetState старт dispose()');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('🟢 __AnimatedBoxWidgetState старт build()');

    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, child) {
        return Transform.scale(
          scale: _animationController.value,
          child: child,
        );
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: const BoxDecoration(
        color: Colors.teal,
            borderRadius: BorderRadius.all(Radius.circular(30))
        ),
      ),
    );
  }
}
