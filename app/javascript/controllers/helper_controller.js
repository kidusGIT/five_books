import { Controller } from "@hotwired/stimulus";

// import modules
import { url, getRequest } from "./utils";

export default class extends Controller {
  static targets = ["searchField", "searchForm", "mainContainer"];

  getDate(date) {
    const year = new Date(date);
    return year.getFullYear();
  }

  async connect() {
    const link = `${url.http}/books/api/books/all`;
    const books = await getRequest(link);
    await this.drawCards(books);
  }

  async search(e) {
    e.preventDefault();
    const element = this.searchFieldTarget;
    const value = element.value;
    const link = `${url.http}/books/api/books/all?search=${value}`;
    const books = await getRequest(link);
    await this.drawCards(books);
  }

  async drawCards(books) {
    let concat = ``;
    const element = this.mainContainerTarget;

    for (let book of books) {
      let tag = ``;

      if (book.image === "null") {
        tag = `
              <div class="book-item">
                <img class="item-image" src="https://images.template.net/174732/free-story-book-cover-template-edit-online.jpg" alt="">
                <a href="${url.http}/books/${book.id}">
                  <div class="flex-col full-size pad">
                    <span> ${book.title} </span>
                    <div class="height-main"></div>
                    <div class="flex-col">
                      <span> ${book.author}  </span>
                      <span> ${this.getDate(book.year)} - ${book.genre}  </span>
                    </div>
                  </div>
                </a>
            </div>            
          `;
      } else {
        tag = `
              <div class="book-item">
                <img class="item-image" src="${book.image}" alt="">
                <a href="${url.http}/books/${book.id}">
                  <div class="flex-col full-size pad">
                    <span> ${book.title} </span>
                    <div class="height-main"></div>
                    <div class="flex-col">
                      <span> ${book.author}  </span>
                      <span> ${this.getDate(book.year)} - ${book.genre}  </span>
                    </div>
                  </div>
                </a>
            </div>            
          `;
      }

      concat += tag;
    }
    element.innerHTML = concat;
    // return concat;
  }
}
