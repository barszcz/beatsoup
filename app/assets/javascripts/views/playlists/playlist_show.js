Soundclone.Views.PlaylistShow = Backbone.CompositeView.extend({

  initialize: function () {
    this.listenTo(this.model, "sync", this.render)
  },

  events: {
    "click button.remove-track": "removeTrack"
  },

  template: JST['playlists/show'],

  render: function () {
    var that = this;
    this.$el.html(this.template({playlist: this.model}));
    this.model.tracks().each(function (track) {
      var trackView = new Soundclone.Views.TrackPlayer({model: track});

      that.addSubview(".playlist-tracks", trackView)

      if (currentUser.id === that.model.get('owner_id')) {
        trackView.$el.append('<button class="remove-track" data-id="' + track.id + '">Remove</button>');
      };

    });
    return this;
  },

  removeTrack: function (event) {
    event.preventDefault();
    var view = this;
    var trackId = $(event.currentTarget).data("id")
    this.model.removeTrack(trackId, {
      success: function () {
        view.model.fetch();
      }
    });
  }
})
