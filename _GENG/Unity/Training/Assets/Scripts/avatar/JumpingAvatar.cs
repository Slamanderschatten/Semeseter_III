using Unity.VisualScripting;
using UnityEngine;

namespace avatar
{
    public class JumpingAvatar : MonoBehaviour
    {
        public float jumpDuration;
        public AnimationCurve jumpCourse;

        private Vector3 lastPos;
        private Vector3 targetPos;
        private Quaternion lastRotation;
        private Quaternion targetRotation;
        private float progress;
        private bool jumpActive;

        public void JumpTo(Vector3 targetPosition)
        {
            progress = 0;
            lastPos = transform.position;
            targetPos = targetPosition;
            lastRotation = transform.rotation;
            targetRotation = Quaternion.LookRotation(targetPosition - lastPos, Vector3.up);
            jumpActive = true;
        }


        void Update()
        {
            if(jumpActive)
            {
                progress += Time.deltaTime / jumpDuration;
                float relation = jumpCourse.Evaluate(progress);
                transform.position = Vector3.Lerp(lastPos, targetPos, relation);


                transform.rotation = Quaternion.Slerp(
                    lastRotation,
                    targetRotation,
                    relation
                );

                if (progress >= 1)
                    jumpActive = false;
            }
        }
    }
}