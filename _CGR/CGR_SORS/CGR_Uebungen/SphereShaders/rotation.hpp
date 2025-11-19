#ifndef ROTATION_HPP
#define ROTATION_HPP
#include <QElapsedTimer>
#include "shader.hpp"
#include "rendering/irenderableproperty.hpp"

//! Diese Klasse realisiert einen einfachen Timer, der als RenderableProperty an Renderables
//! angehängt werden kann.
//! Die zugehörigen Shader erhalten dann den Wert von mTime über die Uniform Time
//! mTime bewegt sich in mMsecsPerIteration von 0 nach 1 und beginnt dann wieder von 0
class Rotation: public IRenderableProperty
{
public:
    explicit Rotation(QVector3D euler) {
        rotationPerTime = euler;
        rotationQ = QQuaternion::fromEulerAngles(0,0,0);
        rotation.rotate(rotationQ);
        mTimer.start();
    }

    void preRender(Shader &pShader) override {
        rotationQ = QQuaternion::fromEulerAngles(rotationPerTime * 0.03);
        rotation.rotate(rotationQ);
        pShader.shaderProgram()->setUniformValue("Rotation", rotation);
    }

protected:
    QVector3D rotationPerTime;
    QQuaternion rotationQ;
    QMatrix4x4 rotation;
    QElapsedTimer mTimer;
};

#endif // ROTATION
