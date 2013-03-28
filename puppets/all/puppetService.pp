cron { puppetService:
  command => "/root/scripts/pup-update",
  user    => root,
  minute  => '*/1'
}
file { '/root/scripts/pup-update':
    ensure  => present,          # файл должен существовать
    content => '/root/puppets/pup-check -update > /root/pup.log',  # содержимым файла должна являться строка "Hello, world!"
    mode    => 0700, 
    owner   => 'root',
    group   => 'root'  
}
