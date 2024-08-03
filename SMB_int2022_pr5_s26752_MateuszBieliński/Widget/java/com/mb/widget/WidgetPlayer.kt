package com.mb.widget

import android.content.Context
import android.media.MediaPlayer


class WidgetPlayer {
    companion object {
        val songs = hashMapOf(
            0 to R.raw.music1,
            1 to R.raw.music2,
            2 to R.raw.music3)
        var current = 0

        var mediaPlayer: MediaPlayer? = null

        fun play(context: Context): Int {
            if(mediaPlayer == null) {
                mediaPlayer = MediaPlayer.create(context, songs[current]!!)
            }

            if(!mediaPlayer!!.isPlaying) {
                mediaPlayer!!.start()
            }

            return current
        }

        fun pause() {
            if(mediaPlayer != null) {
                mediaPlayer!!.pause()
            }
        }

        fun stop() {
            if(mediaPlayer != null) {
                mediaPlayer!!.stop()
                mediaPlayer!!.release()
                mediaPlayer = null
            }
        }

        fun next(context: Context): Int {
            stop()

            current = Utils.getNext(current, songs.size)

            play(context)

            return current
        }

        fun prev(context: Context): Int {
            stop()

            current = Utils.getPrev(current, songs.size)

            play(context)

            return current
        }

    }
}