
using UnityEngine;

namespace flora
{
    public class FlowerGrowing : MonoBehaviour
    {
        public float minGrowingDuration;
        public float maxGrowingDuration;
        private float duration;
        private float progress;
        private int mode;

        void Awake()
        {
            duration = Random.Range(minGrowingDuration, maxGrowingDuration);
            transform.localScale = Vector3.zero;
        }


        void Update()
        {
            progress += Time.deltaTime / duration;
            switch (mode)
            {
                case 0:
                    break;
                case 1:
                    transform.localScale = Vector3.Lerp(Vector3.zero, Vector3.one, progress);
                    break;
                case 2:
                    break;
                case 3:
                    transform.localScale = Vector3.Lerp(Vector3.one, Vector3.zero, progress);
                    break;
            }

            if (progress >= 1)
            {
                progress = 0;
                mode++;
                if (mode > 3)
                    mode = 0;
            }
        }

    }
}