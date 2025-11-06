using Unity.VisualScripting;
using UnityEngine;

namespace avatar
{
    public class JumpingAvatar : MonoBehaviour
    {
        public float jumpDuration;
        public AnimationCurve jumpCourse;

        public float speed;

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

            GameObject targetObj = new GameObject();
            targetObj.transform.position = targetPosition;
            targetObj.transform.rotation = targetRotation;
            
            // Bewegung mit gleichzeitiger sanfter Rotation
            iTween.MoveTo(gameObject, iTween.Hash(
                "position", targetPosition,
                "speed", speed,
                "easetype", iTween.EaseType.easeInOutSine,
                "orienttopath", true,
                "looktime", 0.5f,
                "axis", "y"
            ));
        }


        void Update()
        {
            /*if(jumpActive)
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
            }*/
        }
    }
}