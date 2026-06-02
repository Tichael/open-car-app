package com.example.open_car_app

import android.app.Application
import io.reactivex.exceptions.UndeliverableException
import io.reactivex.plugins.RxJavaPlugins

class OpenCarApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        // flutter_reactive_ble uses RxAndroidBle (RxJava 2) internally. When
        // the remote device terminates the GATT connection while an in-flight
        // operation has already disposed its subscriber (e.g. during the
        // stale-bond scenario where the firmware closes the link immediately),
        // RxJava 2 has nowhere to route the resulting BleDisconnectedException
        // and wraps it in an UndeliverableException — crashing the process.
        //
        // The recommended fix (https://github.com/dariuszseweryn/RxAndroidBle/wiki/FAQ:-UndeliverableException)
        // is to install a global error handler that silently discards
        // connection-related errors that arrive after their consumer is gone.
        RxJavaPlugins.setErrorHandler { throwable ->
            val cause = if (throwable is UndeliverableException) throwable.cause else throwable
            if (cause != null && isIgnorableBleError(cause)) {
                // Expected during teardown / stale-bond recovery — ignore.
                return@setErrorHandler
            }
            // All other unhandled errors should still propagate so genuine
            // bugs are not silently swallowed.
            Thread.currentThread().uncaughtExceptionHandler
                ?.uncaughtException(Thread.currentThread(), throwable)
        }
    }

    private fun isIgnorableBleError(t: Throwable): Boolean {
        val name = t.javaClass.name
        // Covers BleDisconnectedException, BleGattException, and any other
        // com.polidea.rxandroidble2 error that can arrive late.
        return name.startsWith("com.polidea.rxandroidble2")
    }
}
