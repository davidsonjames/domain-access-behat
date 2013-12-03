<?php

$domain = 'site.dev';

$array = array(
  'master' => array(
    'subdomain' => '',
    'tags' => '@all,@master'
  ),
  'one' => array(
    'subdomain' => 'one.',
    'tags' => '@all,@one,@child'
  ),
  'two' => array(
    'subdomain' => 'two.',
    'tags' => '@all,@two,@child'
  ),
);

if ($argv[1] == 'domains') {
  $return = '';
  foreach ($array as $key => $ar) {
    $return.= $ar['subdomain'] . $domain . ' ';
  }

  print substr($return, 0, strlen($return) -1);
}
if ($argv[1] == 'tags') {
  $return = '';
  foreach ($array as $key => $ar) {
    $return.= $ar['tags'] . ' ';
  }

  print substr($return, 0, strlen($return) -1);
}
return;
