<?php
$mlid = db_select('menu_links', 'ml')
  ->fields('ml', (array('mlid')))
  ->condition('router_path', 'admin/stanford-jumpstart/ready', '=')
  ->execute()
  ->fetchAssoc();
if(isset($mlid['mlid']) && is_numeric($mlid['mlid'])) {
  $mlid = $mlid['mlid'];
  $existing_item = menu_link_load($mlid);
  if(is_array($existing_item) && ($existing_item['router_path'] == 'admin/stanford-jumpstart/ready')) {
    $item = $existing_item;
    $item['hidden'] = 1;
    $item['customized'] = 1;
    menu_link_save($item);
  }
}

