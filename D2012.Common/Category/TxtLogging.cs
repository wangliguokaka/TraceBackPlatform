using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace D2012.Common
{
    public class TxtLogging : LoggingCategory
    {
        public TxtLogging()
        {
            base.Category = "TxtLogCategory";
        }
    }
}
