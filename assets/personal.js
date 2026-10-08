(() => {
  const videos = Array.from(document.querySelectorAll('.personal-video'));

  videos.forEach((video) => {
    video.addEventListener('play', () => {
      videos.forEach((other) => {
        if (other !== video) other.pause();
      });
    });

    const showPlaybackError = () => {
      const message = video.closest('.personal-moment').querySelector('.personal-video-error');
      message.hidden = false;
    };
    video.addEventListener('error', showPlaybackError);
    video.querySelectorAll('source').forEach((source) => {
      source.addEventListener('error', showPlaybackError);
    });
  });
})();
