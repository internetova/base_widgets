##  Выбор виджета для использования

Работа флаттер разработчика связана с созданием собственных виджетов. Такие виджеты называются компоновочными, так как они состоят из уже готовых виджетов фреймворка. Это виджеты компонентов и виджеты, отвечающие за их размеры, расположение и отрисовку.

Иногда нам надо просто вывести на экран статическую информацию, например текст, а иногда элемент, с которым можно взаимодействовать.

Для отрисовки статической информации используется **StatelessWidget**.

```dart
class FirstWidget extends StatelessWidget {
  final String title;
  final String text;

  const FirstWidget({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        Text(text),
      ],
    );
  }
}
```

У него есть **конструктор** для задания свойств виджета и метод **build**, в котором мы описываем наш интерфейс.

Если нам необходимо создавать элементы, с которыми можно взаимодействовать, то используется **StatefulWidget**.  В качестве примера можно привести счетчик, который создается при создании нового проекта.  Данный виджет состоит из текста где отображаем текущее значение счетчика и кнопки, с помощью которой это значение увеличивается.

``` dart
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

StatefulWidget состоит из двух частей:
1. Сам виджет, у которого нет метода build, но есть метод createState.
2. Состояние виджета, которое может изменяться в течение срока службы виджета. А метод build переехал в состояние.

Почему две части? Для оптимизации. Виджеты при изменении конфигурации отбрасываются и перестраиваются, а State остается.

**Выводы:**

Для простого вывода статической информации используем StatelessWidget.

Если необходимо взаимодействие с пользователем, то используем StatefulWidget.

### Жизненный цикл виджетов

Рассмотрено в ветке [https://github.com/internetova/base_widgets/tree/жизненный-цикл](https://github.com/internetova/base_widgets/tree/жизненный-цикл)

