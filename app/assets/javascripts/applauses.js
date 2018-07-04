function applauseClick(button) {
  if (button.attr('data-method') == 'POST') {
    postApplause(button.attr('data-film-id'), button.attr('data-category'), button);
  } else if (button.attr('data-method') == 'DELETE') {
    deleteApplause(button.attr('data-film-id'), button.attr('data-category-id'), button);
  }
}

function postApplause(filmId, category, button) {
  $.ajax({url: '/films/' + filmId +'/applauses',
          type: 'POST',
          beforeSend: function(xhr) { xhr.setRequestHeader('X-CSRF-TOKEN', $('meta[name="csrf-token"]').attr('content'))},
          data: {
            film: filmId,
            category: category
          },
          success: function(response) {
                     button.text('-');
                     button.attr('data-category-id', response.applause.id);
                     button.attr('data-method', 'DELETE');
                     button.attr('class', 'btn btn-primary btn-round')

                     updateTotal(response.film.id, response.applause.total);
                   }
          }
  )
}

function deleteApplause(filmId, applauseId, button) {
  $.ajax({url: '/films/' + filmId + '/applauses/' + applauseId,
          type: 'DELETE',
          beforeSend: function(xhr) { xhr.setRequestHeader('X-CSRF-TOKEN', $('meta[name="csrf-token"]').attr('content'))},
          success: function(response) {
                     button.text('+');
                     button.attr('data-method', 'POST');
                     button.removeAttr('data-category-id');
                     button.attr('class', 'btn btn-outline-primary btn-round')

                     updateTotal(response.film.id, response.applause.total)
                   }
         }
  )
}

function updateTotal(filmId, count) {
  total = $('strong[data-film-id="' + filmId + '"][data-type="total"]')[0]
  total.innerHTML = ('+ ' + count)
}

