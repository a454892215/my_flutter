
typedef VoidCallback = void Function();

typedef IntCallback = void Function(int i);

typedef DoubleCallback = void Function(double d);

typedef NumCallback = void Function(num n);

typedef StringCallback = void Function(String s);

typedef BollCallback = void Function(bool b);

typedef DynamicCallback = void Function(dynamic d);

typedef DurationCallback = void Function(Duration duration);

typedef Callback<T> = void Function(T t);
typedef Callback2<T, D> = void Function(T t, D d);