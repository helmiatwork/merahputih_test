import { Controller } from "@hotwired/stimulus"
import $ from 'jquery';
import "selectize"

export default class extends Controller {
  connect() {    
    $(".selectize").selectize()
    $('#transfer_code').selectize({
      onChange: function(value) {
        window.location.href = "?type="+value
      }
    })
  }
}