#ifndef TIME_HPP
#define TIME_HPP
#include <QElapsedTimer>
#include "shader.hpp"
#include "rendering/irenderableproperty.hpp"

//! Diese Klasse realisiert einen einfachen Timer, der als RenderableProperty an Renderables
//! angehängt werden kann.
//! Die zugehörigen Shader erhalten dann den Wert von mTime über die Uniform Time
//! mTime bewegt sich in mMsecsPerIteration von 0 nach 1 und beginnt dann wieder von 0
class Time: public IRenderableProperty
{
public:
    Time(){mTimer.start();}
    Time(unsigned pmSecsPerIteration) {}

    void preRender(Shader &pShader) override {
        mTime = mTimer.elapsed();
        pShader.shaderProgram()->setUniformValue("Time", mTime);
    }

protected:
    GLfloat mTime{0.0f};
    QElapsedTimer mTimer;
};

#endif // TIME_HPP
