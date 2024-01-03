import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="cart"
export default class extends Controller {
  connect() {}

  cartCardItems() {
    `
    <div class="large-screen">
    <div class="width-md-2 flex-gap flex-row pad border-radius shadow">
      <div>
        <% if book.image.attached? %>
          <% if book.image.image? %>
            <%= image_tag book.image, class: 'image-size-small' %>
          <% end %>
        <% else %>
          <img class="image-size-small" src="https://images.template.net/174732/free-story-book-cover-template-edit-online.jpg" alt="">
        <% end %>
        <%# <img class="image-size-small" src="https://images.template.net/174732/free-story-book-cover-template-edit-online.jpg" alt=""> %>
      </div>
      <%# detail container %>
      <div class="flex-col pad flex-gap flex-1">
        <%# TITLE %>
        <div class="width-large flex-row flex-space-between">
          <h3> <%= book.title %> </h3>
          <button class="btn btn-danger"> Return this book </button>
        </div>
        <span> <%= book.author %> </span>
        <span> <%= book.genre %> - <%= book.year.year %> </span>
        <span>
          <% if book.description.length >= 400 %>
            <%= book.description[0..400] %>...
          <% else %>
            <%= book.description %>
          <% end %>
        </span>
        <%# OTHER PART %>
      </div>
    </div>
  </div>
  <%# responsive screen %>
  <div class="small-screen">
    <div class="width-large flex-gap flex-col pad border-radius shadow">
      <div>
        <% if book.image.attached? %>
          <% if book.image.image? %>
            <%= image_tag book.image, class: 'image-size-small' %>
          <% end %>
        <% else %>
          <img class="image-size-small" src="https://images.template.net/174732/free-story-book-cover-template-edit-online.jpg" alt="">
        <% end %>
        <%# <img class="image-size-small width-large" src="https://images.template.net/174732/free-story-book-cover-template-edit-online.jpg" alt=""> %>
      </div>
      <%# detail container %>
      <div class="flex-col pad flex-gap ">
        <%# TITLE %>
        <div class="flex-col">
          <h3> <%= book.title %> </h3>
          <button class="btn btn-danger width-large"> Return this book </button>
        </div>
        <span> <%= book.author %> </span>
        <span> <%= book.genre %> - <%= book.year %> </span>
        <span>
          <% if book.description.length >= 400 %>
            <%= book.description[0..400] %>...
          <% else %>
            <%= book.description %>
          <% end %>
        </span>
        <%# OTHER PART %>
      </div>
    </div>
  </div>
  
    `;
  }
}
