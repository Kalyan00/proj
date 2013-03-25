file { '/tmp/helloworld':
    ensure  => present,          # файл должен существовать
    content => 'Hello, world!',  # содержимым файла должна являться строка "Hello, world!"
    mode    => 0644,             # права на файл - 0644
    owner   => 'root',           # владелец файла - root
    group   => 'root'            # группа файла - root
}