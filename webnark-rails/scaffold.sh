#!/bin/bash

rails generate scaffold Service \
  name:string \
  description:text \
  url:string \
  slug:string \
  hosting_provider:string \
  country:string \
  screenshot_url:string

rails generate scaffold ReportCategory \
  name:string \
  description:text \
  icon_url:string

rails generate scaffold ReportItem \
  report_category_id:integer \
  name:string \
  description:text \
  help:text 

rails generate scaffold ReportChoice \
  report_item_id:integer \
  name:string \
  bonus:boolean \
  points:integer \
  help:text

rails generate scaffold Answer \
  service_id:integer \
  report_choice_id:integer \
  notes:text
