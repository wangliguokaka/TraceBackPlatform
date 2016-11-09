using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace D2012.Common
{
    public class EventLogging : LoggingCategory
    {
        public EventLogging()
        {
            base.Category = "EventLogCategory";
        }
    }
}
