cron { puppetService:
  command => "/root/puppets/pup-check -update > /root/pup.log",
  user    => root,
  minute  => '*/1'
}
